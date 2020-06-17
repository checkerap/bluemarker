class PaperFilesController < ApplicationController
  before_action :set_paper_file, only: [:show, :edit, :update, :destroy]

  # GET /papers
  # GET /papers.json
  def index
    @paper_files = Paper.all
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
  end

  # GET /papers/new
  def new
    @paper_file       = PaperFile.new
    @paper            = Paper.find params[:paper]
    @paper_file.paper = @paper
  end

  # GET /papers/1/edit
  def edit
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper_file = PaperFile.new paper_file_params
    @paper_file.user_id = current_user.id

    respond_to do |format|
      if @paper_file.save
        @paper_file.document.attach(document_params) if document_params.present?
        
        format.html { redirect_to paper_path(@paper_file.paper), notice: 'Paper was successfully created.' }
        format.json { render :show, status: :created, location: @paper_file }
      else
        format.html { render :new }
        format.json { render json: @paper_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /papers/1
  # PATCH/PUT /papers/1.json
  def update
    respond_to do |format|
      if @paper_file.update(paper_file_params)
        if document_params.present?
          if @paper_file.image.attached?
            document = ActiveStorage::Attachment.find @paper_file.document.id
            document.purge if document
          end
            
          @paper_file.document.attach(document_params)
        end
        
        format.html { redirect_to paper_path(@paper_file.paper), notice: 'Paper was successfully updated.' }
        format.json { render :show, status: :ok, location: @paper_file }
      else
        format.html { render :edit }
        format.json { render json: @paper_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    @paper_file.destroy
    respond_to do |format|
      format.html { redirect_to paper_path(@paper_file.paper), notice: 'File was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper_file
      @paper_file = PaperFile.find params[:id]
    end

    # Only allow a list of trusted parameters through.
    def paper_file_params
      params.require(:paper_file).permit(:title, :description, :user_id, :paper_id, 
      :document)
    end
    
    def document_params
      params.dig(:user, :document)
    end
end
