class ShippingDay < ActiveHash::Base
  self.data = [
    {id: 0, shipping_day: '選択してください'},
    {id: 1, shipping_day: '1~2日で発送'},
    {id: 2, shipping_day: '3~4日で発送'},
    {id: 3, shipping_day: '5~7日で発送'}
  ]
end