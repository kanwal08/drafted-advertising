# Drafted Advertising

This application connects to the Amazon Advertising API and facilitates bid changes via a rules-based approach.

Please update this readme with all information needed to configure, run, and deploy the application.

## Coding practices for now

- Sticking to mainstream technologies and dependencies.

- Tests can wait

- Not trying abstract code unless it repeats at least 3 times. [WET before DRY](https://twitter.com/ID_AA_Carmack/status/1646636487558017030)  

- Readability is more important than clever code and minor performance gains:

  **Bad:** 

      @users = User.where('created_at >= ?', Time.zone.now.beginning_of_day)

  **Good:** 

      today = Time.zone.now.beginning_of_day
      @users = User.where('created_at >= ?', today)

  **Bad:**

      def calculate_total(order)
          order.items.inject(0) { |total, item| total + item.price * item.quantity }
      end

  **Good:**

      def calculate_total(order)
        total = 0
        order.items.each do |item|
          total += item.price * item.quantity
        end
        total
      end

## Setup
1. `rails db:setup` and `rails db:migrate`
2. Create .env in project root and reference .env-sample to populate it
