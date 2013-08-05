class RedactorRails::PicturesController < ApplicationController
  before_filter :redactor_authenticate_member! if RedactorRails.picture_model.new.respond_to?(RedactorRails.devise_user)

  def index
    @pictures = RedactorRails.picture_model.where(
        RedactorRails.picture_model.new.respond_to?(RedactorRails.devise_user) ? { RedactorRails.devise_user_key => redactor_current_member.id } : { })
    render :json => @pictures.to_json
  end

  def create
    @picture = RedactorRails.picture_model.new

    file = params[:file]
    @picture.data = RedactorRails::Http.normalize_param(file, request)
    if @picture.respond_to?(RedactorRails.devise_user)
      @picture.send("#{RedactorRails.devise_user}=", redactor_current_member)
      @picture.assetable = redactor_current_member
    end

    if @picture.save
      render :text => { :filelink => @picture.url }.to_json
    else
      render :nothing => true
    end
  end
end
