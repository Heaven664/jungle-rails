require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "saves a product successfully" do 
      @category = Category.create!(:name => "Flowers")
      @product = Product.create!(
        :name => "Rose", 
        :description => "The most popular flower",
        :image => "image_path",
        :price_cents => 500,
        :quantity => 40,
        :category_id => @category.id
      )
    end 

    it "doesn't save product without price" do
      @category = Category.create!(:name => "Flowers")
      @product = Product.create(
        :name => "Rose", 
        :description => "The most popular flower",
        :image => "image_path",
        :price_cents => nil,
        :quantity => 40,
        :category_id => @category.id
      )
      
      error_message = @product.errors.full_messages[0];
      expect(error_message).to include("Price cents is not a number")
    end

    it "doesn't save product without quantity" do
      @category = Category.create!(:name => "Flowers")
      @product = Product.create(
        :name => "Rose", 
        :description => "The most popular flower",
        :image => "image_path",
        :price_cents => 500,
        :quantity => nil,
        :category_id => @category.id
      )
      
      error_message = @product.errors.full_messages[0];
      expect(error_message).to include("Quantity can't be blank")
    end

    it "doesn't save product without category" do
      @category = Category.create!(:name => "Flowers")
      @product = Product.create(
        :name => nil, 
        :description => "The most popular flower",
        :image => "image_path",
        :price_cents => 500,
        :quantity => 40,
        :category_id => nil
      )
      
      error_message = @product.errors.full_messages[0];
      expect(error_message).to include("Category must exist")
    end

    it "doesn't save product without name" do
      @category = Category.create!(:name => "Flowers")
      @product = Product.create(
        :name => nil, 
        :description => "The most popular flower",
        :image => "image_path",
        :price_cents => 500,
        :quantity => 40,
        :category_id => @category.id
      )
      
      error_message = @product.errors.full_messages[0];
      expect(error_message).to include("Name can't be blank")
    end
  

  end
end

