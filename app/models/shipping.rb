class Shipping < ActiveHash::Base
  self.data = [
    {id: 0, shipping: '選択してください'},
    {id: 1, shipping: '送料込み(出品者負担)'},
    {id: 2, shipping: '着払い(購入者負担)'}
  ]
end