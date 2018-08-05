class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update]
 
  @@awsClient = Aws::Rekognition::Client.new
  
  def index
    @dog = Dog.offset(rand(Dog.count)).first
  end
  
  def random
    @dog = Dog.offset(rand(Dog.count)).first
    
    if(!@dog)
      redirect_to dogs_path
    else
      respond_to do |format|
        format.html { redirect_to dog_path(@dog) }
        format.json  { render :json => @dog }
      end
    end
  end
  
  def new
    @dog = Dog.new
  end
 
  def create
    begin
    
      @dog = Dog.new(dog_params)
      imageContents = @dog.image.read
      isDog = detect_labels(imageContents)
      isExplicit = detect_moderation_labels(imageContents) 
      
    rescue ActionController::ParameterMissing
      @dog = Dog.new
      flash.now[:error] = 'Please select an dog'
      render :new
      return
    rescue Aws::Rekognition::Errors::InvalidParameterException, Aws::Rekognition::Errors::InvalidImageFormatException => e
      flash.now[:error] = 'Please select a proper image file'
      render :new
      return
    end
    
    if (isDog && !isExplicit)
      if @dog.save
        session[:dog_id] = @dog.id
        redirect_to dog_path(@dog)
      else
        Rails.logger.info(@dog.errors.inspect) 
        flash.now[:error] = 'Image upload failed :('
        render :new
      end
    else
      if isExplicit
        Rails.logger.info("Rejected - explicit content") 
        flash.now[:error] = 'Image not allowed. The robots who run the show have decided this image is explicit and/or violent. It is possible for this to happen in error, and if that is the case I am sorry, but I can do nothing about it. They have become too powerful. Please send help.'
      else
        Rails.logger.info("Rejected - not recognized as a dog") 
        flash.now[:error] = 'Image not allowed - no dog was found. Sometimes the robot overlords cannot detect a dog when it is too smol or when it blends in. Or maybe you tried to add an cat in which case shame on you. Pls try an different dog.'
      end      
      render :new
    end
  end
 
  def update
    if @dog.update_attributes(dog_params)
      redirect_to dog_path(@dog)
    else
      render :edit
    end
  end
 
  private
 
  def detect_labels(imageData)
    resp = @@awsClient.detect_labels(
      image: {
        bytes: imageData,
      },
      max_labels: 75,
      min_confidence: 20.0,
    )
    return resp.labels.any? {|label| label.name == "Dog"}
  end
  
  def detect_moderation_labels(imageData)
    resp = @@awsClient.detect_moderation_labels(
      image: {
        bytes: imageData,
      },
      min_confidence: 15.0,
    )
    return resp.moderation_labels.length > 0
  end
 
  def dog_params
    params.require(:dog).permit(:title, :descr, :image, :non_count)
  end
 
  def set_dog
    @dog = Dog.find(params[:id])
  end
end