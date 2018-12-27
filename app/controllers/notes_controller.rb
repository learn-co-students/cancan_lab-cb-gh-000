class NotesController < ApplicationController
	before_action :login_required
	before_action :set_note, only: [:show, :edit, :update]
	
	def new
		@note = Note.new
	end

	def create
		@note = Note.new(note_params)
		@note.user = current_user
		@note.viewers.build(user: current_user)
		@note.save
		redirect_to '/' 
	end

	def show
		authorize! :read, @note
	end

	def edit

	end

	def update
		authorize! :update, @note
		@note.update(note_params)
		redirect_to '/'
	end

	private

	def note_params
		params.require(:note).permit(:content, :visible_to)
	end

	def set_note
		@note = Note.find(params[:id])
	end
end
