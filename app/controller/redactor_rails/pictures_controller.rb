class RedactorRails::PicturesController < ApplicationController
  before_filter :redactor_authenticate_member! if RedactorRails.picture_model.new.respond_to?(RedactorRails.devise_member)

  def index
    @pictures = RedactorRails.picture_model.where(
        RedactorRails.picture_model.new.respond_to?(RedactorRails.devise_member) ? { RedactorRails.devise_member_key => redactor_current_member.id } : { })
    render :json => @pictures.to_json
  end

  def create
    @picture = RedactorRails.picture_model.new

    file = params[:file]
    @picture.data = RedactorRails::Http.normalize_param(file, request)
    if @picture.respond_to?(RedactorRails.devise_member)
      @picture.send("#{RedactorRails.devise_member}=", redactor_current_member)
      @picture.assetable = redactor_current_member
    end

    if @picture.save
      render :text => { :filelink => @picture.url }.to_json
    else
      render :nothing => true
    end
  end
end
