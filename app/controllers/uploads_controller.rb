# encoding: UTF-8
class UploadsController < ApplicationController

  def new
  end

  def index

  end

  def import
    spreadsheet = self.open_spreadsheet(params[:file])

    redirect_to root_url, notice: "File imported."
  end

  def open_spreadsheet(file)
    Roo::Excel.new(file.path, nil, :ignore)
  end

end
