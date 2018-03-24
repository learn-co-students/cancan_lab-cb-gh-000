class NotesController < ApplicationController
  load_and_authorize_resource only: [:edit, :show, :update]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def new
    @note = Note.new
    # authorize! :new, @note
  end

  def index
    @notes = Note.all
    # authorize! :index, @notes
  end

  def create
    if current_user
      note = Note.create(post_params) do |n|
        n.user = current_user
        n.visible_to = current_user.name
      end
    end
    redirect_to note_path(note)
    # authorize! :create, @note
  end

  def update
    # binding.pry
    @note = Note.find(params[:id])
    @note.update(post_params)
    redirect_to '/'
  end

  def show
    @note = Note.find(params[:id])
  end

  private

  def post_params
    params.require(:note).permit(:content, :visible_to)
  end
end
