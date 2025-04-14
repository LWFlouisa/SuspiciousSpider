# Amount of days in a year.
$current_day = 0
$lunar_ticks = 30

# Specific invetory
$mechanical_shovel     = false
$mechanical_hammer     = false
$suspicious_teeshirt   = false
$flashlight            = false
$has_spider            = false

## Metrics
$contamination_cleaned = 0
$zombies_bludgeoned    = 0
$zombies_strangled     = 0

$player_hp   = 10 * $player_level
$player_atk  =  2 * $player_level
$player_heal =  2 * $player_level

$enemy_hp  = 2  * $enemy_level
$enemy_atk = 10 * $enemy_level # player gets 5 damage when factoring in healing rate.

# How many traps have you disabled so far?
$has_spider   = false
$trap_counter = 0

def lunar_calender
  def self.new_moon
    $player_hp   = 10 * $player_level
    $player_atk  =  2 * $player_level
    $player_heal =  2 * $player_level

    $enemy_hp  = 2  * $enemy_level
    $enemy_atk = 10 * $enemy_level # player gets 5 damage when factoring in healing rate.
  end

  def self.waxing_crescent
    $player_hp   = 9 * $player_level
    $player_atk  = 2 * $player_level
    $player_heal = 2 * $player_level

    $enemy_hp  = 4 * $enemy_level
    $enemy_atk = 8 * $enemy_level # Player gets exactly 4 damage when factoring in healing rate as defence.
  end

  def self.first_quarter
    $player_hp   = 7 * $player_level
    $player_atk  = 2 * $player_level
    $player_heal = 2 * $player_level

    $enemy_hp  = 6 * $enemy_level
    $enemy_atk = 6 * $enemy_level # player gets 3 damage when factoring in healing rate.
  end

  def self.waxing_gibbous
    $player_hp   = 6 * $player_level
    $player_atk  = 2 * $player_level
    $player_heal = 2 * $player_level

    $enemy_hp    = 8 * $enemy_level
    $enemy_atk   = 4 * $enemy_level # Player gets exactly 2 Damage when factoring in healing as defence. 
  end

  def self.full_moon
    $player_hp   = 4 * $player_level
    $player_atk  = 2 * $player_level
    $player_heal = 2 * $player_level

    $enemy_hp  = 10 * $enemy_level
    $enemy_atk =  2 * $enemy_level # Player gets exactly 1 damage when factoring in healing rate as defence.
  end

  def self.waning_gibbous
    $player_hp   = 6 * $player_level
    $player_atk  = 2 * $player_level
    $player_heal = 2 * $player_level

    $enemy_hp  = 8 * $enemy_level
    $enemy_atk = 4 * $enemy_level # Player gets exactly 2 damage when factoring in healing as defence.
  end

  def self.last_quarter
    $player_hp  = 7 * $player_level
    $player_atk = 2 * $player_level

    $enemy_hp  = 4 * $enemy_level
    $enemy_atk = 6 * $enemy_level # Player gets exactly 3 damage when factoring in healing as defence.
  end

  def self.waning_crescent
    $player_hp   = 8 * $player_level
    $player_atk  = 2 * $player_level
    $player_heal = 2 * $player_level # player gets exactly 4 damage when factoring in healing as defence.

    $enemy_hp  = 2 * $enemy_level
    $enemy_atk = 8 * $enemy_level
  end
end

####################################################################################
#                            LIGHTING HIDDEN ROOMS                                 #
####################################################################################
# Chooses a room to light up based on what the player's current room is.           #
####################################################################################
def light_room
  $driveway   = File.read("lib/maps/driveway.txt")
  $garage     = File.read("lib/maps/garage.txt")
  $laundry    = File.read("lib/maps/laundry.txt")
  $livingroom = File.read("lib/maps/livingroom.txt")
  $sunroom    = File.read("lib/maps/sunroom.txt")
  $kitchen    = File.read("lib/maps/kitchen.txt")
  $hallway    = File.read("lib/maps/hallway.txt")
  $bathroom   = File.read("lib/maps/bathroom.txt")
  $bedroom    = File.read("lib/maps/bedroom.txt")
  $gameroom   = File.read("lib/maps/gameroom.txt")
end

####################################################################################
#                               TASK MANAGER                                       #
####################################################################################
# This manages the different tasks that the player must perform.                   #
####################################################################################
def find_tools
  #tools_available = File.readlines("lib/inventory/possible_items.txt")

  #                       flashlight  mechanical shovel  mechanical hammer  suspicious tee shirt
  # flashlight            f,f         f,ms               f,mh               f,st
  # mechanical shovel     ms,f        
  # mechanical hammer
  # suspicious tee shirt

  possible_tools = [
    [["flashlight",          "flashlight"], ["flashlight",          "mechanical shovel"], ["flashlight",          "machanical hammer"], ["flashlight",          "suspicious teeshirt"]],
    [["mechanical shovel",   "flashlight"], ["mechanical shovel",   "mechanical shovel"], ["mechanical shovel",   "machanical hammer"], ["mechanical shovel",   "suspicious teeshirt"]],
    [["mechanical hammer",   "flashlight"], ["mechanical hammer",   "mechanical shovel"], ["mechanical hammer",   "machanical hammer"], ["mechanical hammer",   "suspicious teeshirt"]],
    [["suspicious teeshirt", "flashlight"], ["suspicious teeshirt", "mechanical shovel"], ["suspicious teeshirt", "machanical hammer"], ["suspicious teeshirt", "suspicious teeshirt"]],
  ]

  row_options = [0, 1, 2, 3]
  col_options = [0, 1, 2, 3]
  arr_options = [0, 1]

  cur_row = row_options.sample
  cur_col = col_options.sample
  cur_arr = arr_options.sample

  found_tool = possible_tools[cur_row][cur_col][cur_arr]

  if    found_tool == "flashlight"
    if $flashlight == false
      $flashlight = true

      print "You found a flashlight."
    else
      print "You already found the flashlight, this one winds up so you'll never run out of zombie juice."
    end

  elsif found_tool ==     "mechanical shovel"
    if $mechanical_shovel == false
      $mechanical_shovel = true

      print "You found a mechanical shovel. But do you trust it? It's seen things!"
    else
      puts "You already found out the shovel you found is watching you.."
    end

  elsif found_tool ==     "mechanical hammer"
    if $mechanical_hammer == false
      $mechanical_hammer = true

      print "You found a mechanical hammer."
    else
      print "You already found the mechanical hammer."
    end

  elsif found_tool ==      "suspicious tee shirt"
    if $suspicious_teeshirt == false
      $suspicious_teeshirt = true

      print "You forgot that you could just take off your shirt and strangle your enemies. Live fearlessly."
    else
      print "You already found your mechanical tee shirt."
    end

  end
end

def matraque # Smash with hammer
  if $mechanical_hammer == false
    puts "You don't have a shovel, and must look for one."

    puts "Would you like to find tools? << "; find_tools = gets.chomp

    if    find_tools ==   "find"; find_tools
    elsif find_tools == "search"; find_tools
    elsif find_tools ==  "scout"; find_tools
    else
      puts ">> Your command was not understood."
    end
  else
    $zombies_bludgeoned = $zombies_bludgeoned + 2
    $player_hp = $player_hp - 1

    print "You bludgeoned two zombies with a hammer: #{$zombies_bludgeoned}. You lost one hp: #{$player_hp}"

    sleep(1.5)
  end
end

def sekupu   # Scoop with shovel
  if $mechanical_shovel == false
    puts "You don't have a shovel, and must look for one."

    puts "Would you like to find tools? << "; find_tools = gets.chomp

    if    find_tools ==   "find"; find_tools
    elsif find_tools == "search"; find_tools
    elsif find_tools ==  "scout"; find_tools
    else
      puts ">> Your command was not understood."
    end
  else
    $contamination_cleaned = $contamination_cleaned + 1

    print "You scooped up contamination and filth from the floor of the mansion: #{$contamination_cleaned}"

    sleep(1.5)
  end
end

def wurgen   # Strangle with tee shirt.
  if $suspicious_teeshirt == false
    puts "You don't have a suspicious tee shirt lying around, and must look for one."

    puts "Would you like to find tools? << "; find_tools = gets.chomp

    if    find_tools ==   "find"; find_tools
    elsif find_tools == "search"; find_tools
    elsif find_tools ==  "scout"; find_tools
    else
      puts ">> Your command was not understood."
    end
  else
    $zombies_bludgeoned = $zombies_bludgeoned + 1
    $player_hp = $player_hp - 2

    print "You bludgeoned two zombies with a hammer: #{$zombies_bludgeoned}. You lost one hp: #{$player_hp}"

    sleep(1.5)
  end
end

def raitosalle # Light room with flashlight.
  if $flashlight == false
    puts "You don't have a flashlight, and must look for one."

    puts "Would you like to find tools? << "; find_tools = gets.chomp

    if    find_tools ==   "find"; find_tools
    elsif find_tools == "search"; find_tools
    elsif find_tools ==  "scout"; find_tools
    else
      puts ">> Your command was not understood."
    end
  else
    light_room

    sleep(1.5)
  end
end

def trouvertsuru
  def disarm_trap
    #           inactive explode
    # inactive  i,i      i,e
    # explode   e,i      e,e

    possible_solutions  = [
      [["inactive", "inactive"], ["inactive", "explode"]],
      [["explode",  "inactive"], ["explode",  "explode"]],
    ]

    s_row_options = [0, 1]
    s_col_options = [0, 1]
    s_arr_options = [0, 1]

    s_cur_row = s_row_options.sample
    s_cur_col = s_col_options.sample
    s_cur_arr = s_arr_options.sample

    possible_trap_codes = [
      [["inactive", "inactive"], ["inactive", "explode"]],
      [["explode",  "inactive"], ["explode",  "explode"]],
    ]
    
    tc_row_options = [0, 1]
    tc_col_options = [0, 1]
    tc_arr_options = [0, 1]

    tc_cur_row = s_row_options.sample
    tc_cur_col = s_col_options.sample
    tc_cur_arr = s_arr_options.sample

    pet_solution = possible_solutions[s_cur_row][s_cur_col][s_cur_arr]
    trap_code    = possible_solutions[tc_cur_row][tc_cur_col][tc_cur_arr]

    if pet_solution == trap_code
      print "Your pet spider managed to disarm the trap."

      $trap_counter = $trap_counter + 1
    else
      print "Your pet spider dies in the explosion of a trap. You need a new one."

      $trap_counter = $trap_counter + 1
      $has_spider   = false
    end
  end

  if $has_spider == false
    puts "You don't have a pet spider, and must look for one."

    puts "Would you like to look inside a closet? << "; look_in_closet = gets.chomp

    if    look_in_closet == "look"; find_tools
    elsif look_in_closet == "peek"; find_tools
    elsif look_in_closet == "find"; find_tools
    else
      puts ">> Your command was not understood."
    end
  else
    disarm_trap

    sleep(1.5)
  end
end

loop do
  if $player_hp < 1
    abort
  end

  gamestates = {
    ####################################################################################
    #                    Standard Rock Paper Scissors from Yumemoire                   #
    ####################################################################################
    # This is a holder over from the original Yumemoire game, from which I will be     #
    # continuing in this particular update.                                            #
    ####################################################################################
    "epee"  => "ishi",
    "ishi"  => "bache",
    "bache" => "epee",
  }, {
    ####################################################################################
    #                             French Language commands                             #
    ####################################################################################
    # I am continuing to flesh this out into being a French language RPG series, with  #
    # some influence from the Japanese language.                                       #
    #                                                                                  #
    # Matraque bludgeons the enemy with a shovel once you find one.                    #
    # Sekupu scoops up dirt and filth with the shovel.                                 #
    # Wurgen allows you to strangle the enemy with your tee shirt.                     #
    # Raitosalle allows you to light up a room or passage.                             #
    # Busokaijoplege instructs your spider pig to disarm traps layed out for you.      #
    # Trouvertsuru allows you to find tools you need to complete tasks.                #
    ####################################################################################

    # bludgeon    - matraque       - smash a shovel over your enemies head after finding a shovel.
    # scoop       - sekupu         - scoop up dirt of contamination in haunted areas after finding a shovel
    # strangle    - wurgen         - strangle enemy after taking off your tee shirt.
    # flashlight  - raitosalle     - light a room or passage after finding a flashlight.
    # disarm trap - busokaijoplege - disarm a trap by sending in a monster decoy. 
    # find tools  - trouvertsuru   - find scattered around the mansion

    "matraque"     => "sekupu",
    "sekupu"       => "wurgen",
    "wurgen"       => "raitosalle",
    "raitosalle"   => "busokaijoplege",
    "trouvertsuru" => "matraque",
  }, {
    "ouvert" => "waltz",  # Open and walk
    "waltz"  =>  "slam",  # Walk and slam door behind you.
    "slam"   => "ouvert", # Over the door when you encounter the door again.
  }, {
    "ouvert" => "lire",   # Open a book and read it.
    "lire"   => "etudie", # Read a book to study.
    "etudie" => "slam",   # Study a book to slam it shut.
    "slam"   => "ouvert", # Slam it shut so you can open it again.
  }, {
    ####################################################################################
    #                              Bed Time State Machine                              #
    ####################################################################################
    # This effects whether the player is currently in bed, and tells them to crawl in  #
    # sleep, wake, or crawl out.                                                       #
    ####################################################################################
    "crasse"  => "suimin",  # Crawl in bed to sleep.
    "suimin"  => "reveil",  # Sleep in bed to wake up.
    "reveil"  => "deteint", # Wake up to exit the bed.
    "deteint" => "crasse",  # Exit the bed to recrawl in the bed.
  }, {
    ####################################################################################
    ##                                Lunar Calender                                   #
    ####################################################################################
    # These only effect the internal state, the actual state displayed will still      #
    # default to being in the French language.                                         #
    ####################################################################################
    "new moon"        => "waxing crescent",
    "waxing crescent" => "first quarter",
    "first quarter"   => "waxing gibbous",
    "waxing gibbous"  => "full moon",
    "full moon"       => "waning gibbous",
    "waning gibbous"  => "last quarter",
    "last quarter"    => "waning crescent",
    "waning crescent" => "new moon",
  }, {
    ####################################################################################
    #                                 Enemy Status                                     #
    ####################################################################################
    "inactive" => "active",
    "active"   => "inactive",
  }

  battle_state        = gamestates[0]
  chore_state         = gamestates[1]
  door_state          = gamestates[2]
  read_status         = gamestates[3]
  sleep_status        = gamestates[4]
  calender_de_lunaire = gamestates[5]
  enemy_status        = gamestates[6]
  ####################################################################################
  #                                Main Game State
  ####################################################################################
  if $flashlight == true
    light_room
  else
    print ">> You cannot see anything in this dark room."
  end

  current_chore = chore_state

  puts "Your current task is: #{current_shore}"

  print "What current action would you like to take? ( matraque / sekupu / wurgen / raitosalle / trouvertsuru ) << "; current_action = gets.chomp

  if    "matraque"     == current_action; matraque
  elsif "sekupu"       == current_action; sekupu
  elsif "wurgen"       == current_action; wurgen
  elsif "raitosalle"   == current_action; raitosalle
  elsif "trouvertsuru" == current_action; puts "X Not yet available."
  else
    puts ">> Instruction was not understood."
  end

  ####################################################################################
  ##                         Effects the lunar calender                              #
  ####################################################################################
  # This happens at the end of every player action session that increments one lunar #
  # day, and after every 24 days is one lunar tick. Each lunar state switches to a   #
  # different method that changes the current player hp, atk, and healing abilities. #
  # I will also be factoring in things like what level the player is, and even enemy #
  # grinding and leveling.                                                           #
  ####################################################################################
  $current_day = $current_day + 1

  if $current_day == 24
    $lunar_ticks = $lunar_ticks + 1

    if $lunar_ticks == 30
      current_lunar_state = calender_de_lunaire

      if    current_lunar_state ==        "new mmon"; lunar_calender.new_moon
      elsif current_lunar_state == "waxing crescent"; lunar_calender.waxing_crescent
      elsif current_lunar_state ==   "first quarter"; lunar_calender.first_quarter
      elsif current_lunar_state ==  "waxing gibbous"; lunar_calender.waxing_gibbous
      elsif current_lunar_state ==       "full moon"; lunar_calender.full_moon
      elsif current_lunar_state ==  "waning gibbous"; lunar_calender.waning_gibbous
      elsif current_lunar_state ==    "last quarter"; lunar_calender.last_quarter
      elsif current_lunar_state == "waning crescent"; lunar_calender.waning_crescent
      end
    end
  end
end
