class RepositoryController < ApplicationController
  before_filter :login_required
  
  def index
  end
  
  def create
    @document = Document.new(params[:document])
    debugger
    respond_to do |format|
      if @document.save
        flash[:status]  = "Your file has been saved in the repository."
      else
        flash[:error]  = "Could not upload file."
      end
      format.html {redirect_to :back}
    end
  end
  
  def show
    @document = Document.find_by_doc_file_name(params[:filename]+'.'+params[:format])
    send_file @document.doc.path, :type => @document.doc_content_type, :disposition => 'inline'
  end
  
  def content
    @parent = params[:dir]
    @dir = Jqueryfiletree.new("#{@parent}").get_content
  end

end
