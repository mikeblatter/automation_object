#Simple class for for looping through a condition until ready
class LoopWait
  def initialize(args = {})
    @sleep = args.fetch :sleep
    @loops = args.fetch :loops
    @proc = args.fetch :proc
  end
end