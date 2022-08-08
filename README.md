# In Time Ruby
Ruby client for In Time shipment tracker and parcel creator

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'in-time-ruby', '0.0.1'
```

...followed with:
```
bundle install
```

Or install it with:
```
gem install in-time-ruby
```

## Usage
```
connection = InTimeRuby::Connection.new(url, client_id, client_secret)
```

### Get shipment

```
connection.get_shipment(id)
```

### Create shipment

```
opts = {
  "billingCode": "string",
  "serviceTypeCode": "string",
  "collectionDateTimeFrom": "2022-08-08T17:30:08.040Z",
  "collectionDateTimeTo": "2022-08-08T17:30:08.040Z",
  "deliveryDateTimeFrom": "2022-08-08T17:30:08.040Z",
  "deliveryDateTimeTo": "2022-08-08T17:30:08.040Z",
  "shipFromContactName": "string",
  "shipFromContactPhone": "string",
  "shipFromEmail": "string",
  "shipFromCompanyName": "string",
  "shipFromStreet1": "string",
  "shipFromStreet2": "string",
  "shipFromStreet3": "string",
  "shipFromPostalCode": "string",
  "shipFromCity": "string",
  "shipFromCountry": "string",
  "shipFromContactTypeCode": "string",
  "shipToContactName": "string",
  "shipToContactPhone": "string",
  "shipToEmail": "string",
  "shipToCompanyName": "string",
  "shipToStreet1": "string",
  "shipToStreet2": "string",
  "shipToStreet3": "string",
  "shipToPostalCode": "string",
  "shipToCity": "string",
  "shipToCountry": "string",
  "shipToContactTypeCode": "string",
  "productDescription": "string",
  "goodsValue": 0,
  "goodsValueCurrencyCode": "string",
  "parcelQuantity": 0,
  "weight": 0,
  "pickupNote": "string",
  "specialNote": "string",
  "costCenterCode": "string",
  "deliveryNote": "string",
  "packageTypeCode": "string",
  "cashOnDelivery": 0,
  "externalNumber": "string",
  "externalNumber2": "string",
  "documentationReturn": true,
  "personallyHandover": true,
  "fragile": true,
  "specialPackaging": true,
  "shippingDocument": "string",
  "parcelReturnQuantity": 0,
  "insurance": true
}

connection.create_parcel(opts)
```

### Confirm shipment by tracking number

```
connection.confirm_shipment(tracking_number)
```


## Thank you for using InTimeRuby!


