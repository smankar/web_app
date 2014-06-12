class UploadsController < ApplicationController

  def import
    file = params[:file]
    if file && ".xls" == File.extname(file.original_filename)
      spreadsheet = open_spreadsheet(file)

      @spreadsheet_text = spreadsheet.cell(1,1)
      send_data pdf,
                :filename => "file.pdf",
                :type => "application/pdf"

      flash[:success] = "File Uploaded Successfully"
    else
      flash[:danger] = "Invalid File. Please upload a valid file!"
    end
  end

  private
    def open_spreadsheet(file)
      Roo::Excel.new(file.path, nil, :ignore)
    end

    def pdf
      content = @spreadsheet_text
      Prawn::Document.new do
        font(Rails.root.join('app', 'assets', 'fonts', 'Dvsr3ntt.ttf'), :size => 12)
        text content
      end.render
    end

end
