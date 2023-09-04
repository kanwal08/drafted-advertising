# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Region.create!(name: "North America", code: "NA")
Region.create!(name: "Europe", code: "EU")  
Region.create!(name: "Far East", code: "FE")  

# creater marketplace with regions
Marketplace.create!(name: "Amazon", external_id: 'ATVPDKIKX0DER', country_code: 'US', currency_code: 'USD', region: Region.find_by(name: "North America"))
Marketplace.create!(name: "Amazon AE",  external_id: 'A2VIGQ35RCS4UG', country_code: 'AE', currency_code: 'AED', region: Region.find_by(name: "Far East"))
Marketplace.create!(name: "Amazon AU", external_id: 'A39IBJ37TRP1C6', country_code: 'AU', currency_code: 'AUD', region: Region.find_by(name: "Far East"))
Marketplace.create!(name: "Amazon BR", external_id: 'A2Q3Y263D00KWC', country_code: 'BR', currency_code: 'BRL', region: Region.find_by(name: "North America"))
Marketplace.create!(name: "Amazon CA", external_id: 'A2EUQ1WTGCTBG2', country_code: 'CA', currency_code: 'CAD', region: Region.find_by(name: "North America"))
Marketplace.create!(name: "Amazon DE", external_id: 'A1PA6795UKMFR9', country_code: 'DE', currency_code: 'EUR', region: Region.find_by(name: "Europe"))
Marketplace.create!(name: "Amazon ES", external_id: 'A1RKKUPIHCS9HS', country_code: 'ES', currency_code: 'EUR', region: Region.find_by(name: "Europe"))
Marketplace.create!(name: "Amazon FR", external_id: 'A13V1IB3VIYZZH', country_code: 'FR', currency_code: 'EUR', region: Region.find_by(name: "Europe"))
Marketplace.create!(name: "Amazon IT", external_id: 'APJ6JRA9NG5V4', country_code: 'IT', currency_code: 'EUR', region: Region.find_by(name: "Europe"))
Marketplace.create!(name: "Amazon JP", external_id: 'A1VC38T7YXB528', country_code: 'JP', currency_code: 'JPY', region: Region.find_by(name: "Far East"))
Marketplace.create!(name: "Amazon MX", external_id: 'A1AM78C64UM0Y8', country_code: 'MX', currency_code: 'MXN', region: Region.find_by(name: "North America"))
Marketplace.create!(name: "Amazon NL", external_id: 'ATVPDKIKX0DER', country_code: 'NL', currency_code: 'EUR', region: Region.find_by(name: "Europe"))
Marketplace.create!(name: "Amazon UK", external_id: 'A1F83G8C2ARO7P', country_code: 'GB', currency_code: 'GBP', region: Region.find_by(name: "Europe"))
