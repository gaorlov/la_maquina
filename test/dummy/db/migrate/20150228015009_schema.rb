class Schema < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
    end

    create_table :admins do |t|
      t.string :name
    end

    create_table :traits do |t|
      t.string :name
    end

    create_table :guest_traits do |t|
      t.belongs_to :guest
      t.belongs_to :trait
      t.string :value
    end

    create_table :admin_traits do |t|
      t.belongs_to :user
      t.belongs_to :thing
      t.string :value
    end

    create_table :properties do |t|
      t.references :user, :polymorphic => true
      t.string :value
    end

    create_table :guest_trait_modifiers do |t|
      t.belongs_to :guest_trait
      t.string :modifier
    end

    create_table :admin_trait_modifiers do |t|
      t.belongs_to :admin_trait
      t.string :modifier
    end

    create_table :standalones do |t|
      t.string :value
    end
  end
end
  