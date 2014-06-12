# encoding: UTF-8
class UploadsController < ApplicationController

  def import

    file = params[:file]
    if ".xls" == File.extname(file.original_filename)
      spreadsheet = self.open_spreadsheet(file)
      flash[:success] = "File Uploaded Successfully"
    else
      flash[:danger] = "File not supported"
    end

    redirect_to root_url
  end

  def open_spreadsheet(file)
    Roo::Excel.new(file.path, nil, :ignore)
  end

end
