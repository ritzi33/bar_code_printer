module BarCodePrinter
  class BarCodesController < ApplicationController

    def show
      @bar_code_value = params[:id]
      @first_line_text = params[:first_line_text] || ""
      @second_line_text = params[:second_line_text] || ""

      if @bar_code_value
        bar_code = Barby::Code39.new(@bar_code_value)
        @bar_code_image = bar_code.to_png
      end

      if params[:item_id]
        bar_code_item = Barby::Code39.new(params[:item_id])
        @item_code_image = bar_code_item.to_png if bar_code_item
      end

      if params[:consignment_id]
        bar_code_consignment = Barby::Code39.new(params[:consignment_id])
        @consignment_code_image = bar_code_consignment.to_png
      end

      render :show, layout: false
    end

    def master_picklist
      @no_of_orders = params[:batch_json].collect{ |k| k[:order_number]}.uniq.count
      @no_of_items = params[:batch_json].collect{ |k| k[:product_name]}.count
      @no_of_shipments = params[:batch_json].collect{ |k| k[:shipment_number]}.uniq.count
      
      render :master_picklist, layout: false
    end
  end
end
