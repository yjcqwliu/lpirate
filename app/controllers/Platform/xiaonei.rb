module Function
  def init
  acts_as_xiaonei_controller
  before_filter :set_current_user
  end 
  def set_current_user
    if @current_user.nil?
      @current_user = User.find_or_create_by_xid(xiaonei_session.user.to_i)
      if @current_user.session_key != xiaonei_session.session_key
        @current_user.session_key = xiaonei_session.session_key
        @current_user.save
      end
    end
	if @current_user.friend_ids.nil? or @current_user.friend_ids.size == 0 or @current_user.updated_at > (Time.now - 48.hour)
        res = xiaonei_session.invoke_method("xiaonei.friends.get")
        if res.kind_of? Xiaonei::Error
          @current_user.friend_ids = [] if @current_user.friend_ids.empty?
        else
          @current_user.friend_ids = res
        end
        @current_user.save
	 end 

  end
  
  def current_user
    @current_user
  end
  module_function('init')
end