account = Account.find_by_email('alameda@example.com')
account.build_billing_address()
account.save!
account.billing_address.build_address(
    :first_name => 'Amos',
    :last_name => 'McGoo',
    :street_1 => '123 Park Ave.',
    :city => 'Alameda',
    :state => 'CA',
    :postal_code => '94501',
    :email => 'adammede@gmail.com',
    :phone => '(812)201-8121')
account.billing_address.save!