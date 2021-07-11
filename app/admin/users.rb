ActiveAdmin.register User do
  index do
    id_column
    column :email
    actions
  end

  form title: 'A custom title' do |f|
    inputs 'Details' do
      input :email
      input :password
    end
    actions
  end

  permit_params :email, :password
end
