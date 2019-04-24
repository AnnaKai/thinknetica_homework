#### Rail Creator ####
#
# Launch this file from the command line to get started
#

ROOT = File.dirname(__FILE__)

$LOAD_PATH.unshift(File.join(ROOT, "lib"))
require "main"

main = Main.new
main.launch!
