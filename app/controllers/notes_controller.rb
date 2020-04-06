class NotesController < ApplicationController
  
  rescue_from CanCan::AccessDenied do
    head :unauthorized
  end

  def create
    @note = Note.create(note_params)
    redirect_to '/'

    authorize! :create, @note
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
