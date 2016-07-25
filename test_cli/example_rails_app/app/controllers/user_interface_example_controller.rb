class UserInterfaceExampleController < ApplicationController
  def new_window
  end

  def opened_new_window
    render :layout => 'blank'
  end
end
