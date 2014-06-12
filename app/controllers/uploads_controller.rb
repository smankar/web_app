class UploadsController < ApplicationController

  def import
    file = params[:file]
    if file && ".xls" == File.extname(file.original_filename)
      spreadsheet = open_spreadsheet(file)
      flash[:success] = "File Uploaded Successfully"
    else
      flash[:danger] = "Invalid File. Please upload a valid file!"
    end

    redirect_to root_url
  end

  #def generate
  #  @competition = ResultsInCompetition.find(params[:competition_id])
  #  respond_to do |format|
  #    format.pdf { prawnto :filename => filename, :prawn => {:page_layout => :landscape}}
  #  end
  #end

  private
    def open_spreadsheet(file)
      Roo::Excel.new(file.path, nil, :ignore)
    end

end
