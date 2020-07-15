class NotesController < ApplicationController
  
  rescue_from CanCan::AccessDenied do
    head :unauthorized
  end

  load_and_authorize_resource only: :update

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user_id
    @note.save

    redirect_to '/'

    authorize! :create, @note
  end

  def update

    @note.update(note_params)

    redirect_to '/'

  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
