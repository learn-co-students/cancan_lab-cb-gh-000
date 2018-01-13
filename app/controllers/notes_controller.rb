class NotesController < ApplicationController
  load_and_authorize_resource

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    if @note.save
      redirect_to '/', notice: "Note was successfully created."
    else
      render :new
    end
  end

  def show
    set_note
  end

  def index
    if current_user
      @notes = current_user.readable
    end
  end

  def edit
    set_note
  end

  def update
    set_note
    @note.update(note_params)
    redirect_to '/'
  end

  def destroy
    set_note
    @note.delete
    redirect_to notes_path
  end

  private

  def set_note
    @note = Note.find_by_id(params[:id])
  end

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end

end
