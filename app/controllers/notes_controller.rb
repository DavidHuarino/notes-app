class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update destroy ]

  # GET /notes or /notes.json
  def index
    @notes = Note.getNotesByCurrentUser(current_user.id)
    @status_to_color = { 'baja' => 'secondary', 'media' => 'warning', 'alta' => 'danger' }
  end

  # GET /notes/1 or /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = current_user.notes.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to notes_path, notice: "Note was successfully created." }
        #format.html { redirect_to note_url(@note), notice: "Note was successfully created." }
        #format.json { render :show, status: :created, location: @note }
      else
        # format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @note.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        #format.html { redirect_to note_url(@note), notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        #format.html { render :edit, status: :unprocessable_entity }
        #format.json { render json: @note.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy
    #redirect_to root_path, status: :see_other
    respond_to do |format|
      format.html { redirect_to root_path, status: :see_other, notice: "Note was removed." }
    #  format.html { redirect_to notes_url, notice: "Note was removed." }
    #  format.turbo_stream { redirect_to root_path }
      #format.html { redirect_to notes_path, notice: "Note was successfully destroyed." }
    #  format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:name, :status, :description)
    end
end
