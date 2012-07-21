class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  # before_filter :authenticate_user!
  # prepend_before_filter :require_admin_access , :only => [ :new, :create, :cancel ]
  # prepend_before_filter :authenticate_scope! #, :only => [:edit, :update, :destroy]

  # GET /resource/sign_up
  def new
    @groups=Group.all
    resource = build_resource({})
    # respond_with resource
  end

  # POST /resource
  def create
    resource = User.new(params[:user])
    # build_resource

    if resource.save
      render :json => {:name=> resource}
      # if resource.active_for_authentication?
      #   set_flash_message :notice, :signed_up if is_navigational_format?
      #   render :json => {:name=> resource}
        # sign_in(resource_name, resource)
        # respond_with resource, :location => after_sign_up_path_for(resource)
      # else
      #   set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
      #   expire_session_data_after_sign_in!
      #   respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      # end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end


  protected

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  # def require_admin_access
  #   unless current_user and current_user.gid==1000
  #     render :text => "no access permission!"
  #   end
  # end

  def after_sign_up_path_for(resource)
    "http://google.com"
  end


  def build_resource(hash = nil, options = {})
    hash ||= resource_params || {}

    if options[:unsafe]
      self.resource = resource_class.new.tap do |resource|
        hash.each do |key, value|
          setter = :"#{key}="
          resource.send(setter, value) if resource.respond_to?(setter)
        end
      end
    else
      self.resource = resource_class.new(hash)
    end
  end

end
