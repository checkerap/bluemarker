class MessageBoardsController < ApplicationController
  before_action :set_message_board, only: [:show, :edit, :update, :destroy]

  # GET /message_boards
  # GET /message_boards.json
  def index
    @message_boards = MessageBoard.all
  end

  # GET /message_boards/1
  # GET /message_boards/1.json
  def show
    @topics = Topic.where(message_board_id: @message_board.id)
  end

  # GET /message_boards/new
  def new
    @message_board = MessageBoard.new
  end

  # GET /message_boards/1/edit
  def edit
  end

  # POST /message_boards
  # POST /message_boards.json
  def create
    @message_board = MessageBoard.new(message_board_params)

    respond_to do |format|
      if @message_board.save
        format.html { redirect_to @message_board, notice: 'Message board was successfully created.' }
        format.json { render :show, status: :created, location: @message_board }
      else
        format.html { render :new }
        format.json { render json: @message_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /message_boards/1
  # PATCH/PUT /message_boards/1.json
  def update
    respond_to do |format|
      if @message_board.update(message_board_params)
        format.html { redirect_to @message_board, notice: 'Message board was successfully updated.' }
        format.json { render :show, status: :ok, location: @message_board }
      else
        format.html { render :edit }
        format.json { render json: @message_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_boards/1
  # DELETE /message_boards/1.json
  def destroy
    @message_board.destroy
    respond_to do |format|
      format.html { redirect_to message_boards_url, notice: 'Message board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message_board
      @message_board = MessageBoard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_board_params
      params.require(:message_board).permit(:is_private, :event_id, :title, :description)
    end
end
