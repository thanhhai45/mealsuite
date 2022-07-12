class PhotosController < ApplicationController
  before_action :gallery_data
  before_action :set_photo, only: %i[ show edit update destroy ]

  # GET /photos or /photos.json
  def index
    @pagy, @photos = pagy(@gallery.photos)
  end

  # GET /photos/1 or /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = @gallery.photos.build
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos or /photos.json
  def create
    @photo = @gallery.photos.create(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to gallery_photo_url(@photo.gallery, @photo), notice: "Photo was successfully created." }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to gallery_photo_url(@photo.gallery, @photo), notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to gallery_photos_url, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = @gallery.photos.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def photo_params
    params.require(:photo).permit(:name, :shooting_date, :description, :gallery_id, :image)
  end

  def gallery_data
    @gallery = Gallery.find(params[:gallery_id])
  end
end
