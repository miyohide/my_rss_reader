# ApplicationController はすべてのControllerの基底クラス
class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
end
