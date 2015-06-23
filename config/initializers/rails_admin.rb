RailsAdmin.config do |config|

  config.authorize_with :cancan
  
  config.authorize_with do
    redirect_to main_app.root_path unless warden.user.admin == true
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model User do
    exclude_fields :feeds, :comments,:reset_password_sent_at,:remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
    list do
      field :first_name
      field :last_name
      field :username
      field :email
      field :admin

    end
  end

  config.model Feed do
    exclude_fields :comments,:user
    list do
      field :name do
        label "Username"
      end
    end
  end

  
end
