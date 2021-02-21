class TestsController < Simpler::Controller

  def index
    # render plain: 'Plain text'
    @tests = Test.all
  end

  def create; end

  def show; end
end
