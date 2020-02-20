module PeopleHelper
    def total_invoices
        total = 0
        Person.all.each do |per|
         total += per.total
        end
        total
      end
      def total_sub_total
        total = 0
        Person.all.each do |per|
         total += per.sub_total
        end
        total
      end
      def total_taxes
        total = 0
        Person.all.each do |per|
         total += per.tax
        end
        total
      end
      def total_cost
        total = 0
        Person.all.each do |per|
         total += per.cost
        end
        total
      end
      def total_profit
        total = 0
        Person.all.each do |per|
         total += per.profit
        end
        total
      end
      def total_delivery
        total = 0
        Person.all.each do |per|
         total += per.deliver
        end
        total
      end
      def total_margin
        total = 0
        Person.all.each do |per|
          total += per.margin
          total = (total / Person.all.count).round(2)
        end
        total
        # (total_profit / total_sub_total * 100).round(2)
      end
end
