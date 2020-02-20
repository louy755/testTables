class InvoicePdf < Prawn::Document
    def initialize(person, view_context)
      super(top_margin: 70)
      @person = person
      @view_context = view_context
      info_tab
    end
    def price(num)
      @view_context.number_to_currency(num)
    end
  
    def invoice_number
      text "Invoice \##{@person.phone}", size: 9
    end
    def customer_name
      text "Customer name: #{@person.name.titleize}", size: 9
    end
    def info_tab
      text_box "#{invoice_number}", :kerning => true, :at => [0, y - 40]
      text_box "#{customer_name}", :kerning => true, :at => [380, y - 40]
      image "#{Rails.root}/public/pdf/set1.png", :width => 150, :height => 100, :position => :center
      move_down 10
      address_info
      person_info
      line_items
      move_down 5
      table [["#{price(@person.sub_total)} Sub total"],
           ["#{price(@person.tax)} TAX"],
           ["#{price(@person.deliver)} Delivery"],
           ["#{price(@person.total)} Total Due \n "], 
           ["#{price(@person.amount)} #{@person.payment_method} "],
           ["#{price(@person.amount_two)} #{@person.payment_two_methos} "],
           ["#{price(@person.discount || 0)} Discount"],
           ["#{price(@person.amount +  @person.amount_two + @person.discount)} Payments + Discount -"],
           ["#{price(@person.total)} Total Due"],
           if @person.full_payment == true
            [{:content => "#{price( @person.total)} ACEMA  Finance ",:colspan => 5,:size => 13, :text_color => "006400" }]
           else 
            [{:content => "#{price( @person.total  - (@person.amount  + @person.amount_two + @person.discount))} Remaiming due ",:colspan => 5,:size => 13, :text_color => "ff3300" }]
           end
          ], :position => :right, :column_widths => [190], :cell_style => {:background_color => "FFFFCC"}
    move_down 20
    text "Read over before signing, All deposits are non refundable. 90 days layaway only . ONE PAYMENT EVERY 30 DAY  IS REQUIRED  TO KEEP THE LAYAWAY ACTIVE LAYAWAY WITH NO ACTIVETY FOR 3 MONTHS WILL BE CANCELED .ALL SALES ARE FINAL. All merchandise is sold AS IS INSPECTED By the customer, without warranty, either expressed or implied, except may be offered by the original manufacturer and not the seller. All SALES ARE FINAL and NOT subject to customer cancellation, return. Allowance, charge back, credit adjustments, service or exchange.cus Failure to pick up or accept delivered merchandise may result in20% RESTOCKING FEE OF THE PURCHASE PRICE. Received Merchandise in Good Condition", size: 9
    move_down 25
    text "Customer Signature:  --------------------------------------------------------", size: 10
    move_down 25
    text "Thank You!", size: 11, :align => :center
    end
    def address_info
      text "7601 South Cicero Ave  unit 1486 Chicago il 60652    Phone 773-735-8800 Fax 773-735-8806 \n
      DELIVERY INFORMATION  CALL  773-735-8800", size: 7, style: :bold, :align => :center
    end

    def person_info
      move_down 10
      table line_info_rows do
        row(0).font_style = :bold
        columns(0).width = 90
        columns(2).width = 160
        row(0).style :background_color => '3CB371'
        self.row_colors = [ "FFFFFF", "DDDDDD"]
        self.header = true
      end
    end
    def line_info_rows
      [["Name", "Phone", "Adress", 'Adress2', "city", "State", "Zip"]] +
      [[@person.name, @person.phone, @person.address, @person.address2, @person.city, @person.state, @person.zip]]
    end
    def line_items
      move_down 10
      table line_item_rows do
        row(0).font_style = :bold
        row(0).style :background_color => 'ccf2ff'
        columns(1).width = 110
        columns(2).width = 110
        columns(3).width = 55
        columns(4).width = 60
        columns(5).width = 170
        self.row_colors = [ "FFFFFF", "DDDDDD"]
        self.header = true
      end
    end
    def line_item_rows
      [["QNT", "Item", "Description", "Price", "Subtotal" ,'Date']] +
      @person.items.map do |itm|
        [itm.qunt,itm.item_type, itm.description,  price(itm.price), price(itm.qunt * itm.price) ,itm.created_at.strftime("%A, %d %b %Y")]
      end
    end    
  end
  