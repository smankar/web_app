# encoding: utf-8
class UploadsController < ApplicationController

  def import
    file = params[:file]
    if file && ".xls" == File.extname(file.original_filename)
      spreadsheet = open_spreadsheet(file)

      @spreadsheet_text = spreadsheet.cell(6,3)
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
      header1 = "राम महिला बचत गॅट"
      header2 = "ता. पाटण जी. सतारा"
      header3 = "विषय: घरपोच आहार (ट.ह.र) पुरवठा केलेबाबत."
      header4 = "२०१४-१५"
      left1 = "बाल विकास प्रकल्प अधिकारी "
      left2 = "एकात्मिक बाल विकास सेवा योजना, जिल्हा सातारा "
      left3 = "आंगणवाडी केंद्राचे नावं:"
      left4 = @spreadsheet_text
      left5 = "वरील विषयी विनंती कि, आपल्या आदेशप्रमाणे अंगणवाडी केंद्रास खालील तपशीप्रमाणे"
      left6 = " (Take Home Ration) "
      left7 = "पुरवठा करण्यास आला आहे "
      Prawn::Document.new do
        font_families.update("mangal" => {
            :normal => Rails.root.join('app', 'assets', 'fonts', 'mangal.ttf')
        },"surekh" => {
            :normal => Rails.root.join('app', 'assets', 'fonts', 'Dvsr3ntt.ttf')
        }
        )
        font("mangal") do
         text header1, :size => 24, :align => :center
         text header2, :size => 14, :align => :center
         text header3, :size => 14, :align => :center
         text header4, :size => 12, :align => :center
         move_down 10
         text left1, :size => 8
         text left2, :size => 8
        end
        formatted_text [ { :text => left3, :font => "mangal",  :size => 8 },
                          { :text => left4, :font => "surekh", :size => 14 }
                          ]
        formatted_text [ { :text => left5, :font => "mangal",  :size => 8 },
                         { :text => left6, :font => "Courier", :size => 8 },
                         { :text => left7, :font => "mangal", :size => 8 }
                       ]
      end.render
    end

end
