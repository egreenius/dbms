/*
Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
*/
-- создаем несколько базовых документов, аналог таблицы shop.category
db.shop.insert({"category" : "Процессоры"});
db.shop.insert({"category" : "Материнские платы"});
db.shop.insert({"category" : "Видеокарты"});
db.shop.insert({"category" : "Жесткие диски"});
db.shop.insert({"category" : "Оперативная память"});

-- добавляем ключ products, аналог таблицы products. Products представляет собой массив документов, описывающих конкретный продукт
db.shop.update({category: 'Процессоры'}, 
		{$set: {products: [{name: 'Intel Core i5-7400', 
						description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 
						price: '12700.00', createded_at: '2020-08-01 22:17:36'
						}]
			}
		}
    )
-- добавляем элемент массива - еще один продукт в той же категории    
db.shop.update({category: 'Процессоры'}, 
		{$push: {products: 
					{name: 'Intel Core i3-8100', 
					description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 
					price: '7890.00', createded_at: '2020-08-01 22:17:36'
					}
				}
		}
    )
-- добавляем элемент массива - еще один продукт в той же категории 
db.shop.update({category: 'Процессоры'}, 
		{$push: {products: {name: 'AMD FX-8320E', 
						description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 
						price: '4780.00', createded_at: '2020-08-01 22:17:36'
						}
			}
		}
    )
-- добавляем продукт в новую категорию - Материнские платы    
db.shop.update({category: 'Материнские платы'}, 
		{$set: {products: [{name: 'ASUS ROG MAXIMUS X HERO', 
						description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 
						price: '19310.00', createded_at: '2020-08-01 22:17:36'
						}]
			}
		}
    )
-- добавляем элемент массива - еще один продукт в той же категории     
db.shop.update({category: 'Материнские платы'}, 
		{$push: {products: {name: 'Gigabyte H310M S2H', 
						description: 'H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 
						price: '4790.00', createded_at: '2020-08-01 22:17:36'
						}
			}
		}
    )
-- добавляем элемент массива - еще один продукт в той же категории 
db.shop.update({category: 'Материнские платы'}, 
		{$push: {products: {name: 'MSI B250M GAMING PRO', 
						description: 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 
						price: '5060.00', createded_at: '2020-08-01 22:17:36'
						}
			}
		}
    )
/*
Вывод команды db.shop.find().pretty() после выполнения команды выше.

{
  "_id": "6035359915299e001ff486aa",
  "category": "Процессоры",
  "products": [
    {
      "name": "Intel Core i5-7400",
      "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
      "price": "12700.00",
      "createded_at": "2020-08-01 22:17:36"
    },
    {
      "name": "Intel Core i3-8100",
      "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
      "price": "7890.00",
      "createded_at": "2020-08-01 22:17:36"
    },
    {
      "name": "AMD FX-8320E",
      "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
      "price": "4780.00",
      "createded_at": "2020-08-01 22:17:36"
    }
  ]
}
{
  "_id": "6035359915299e001ff486ab",
  "category": "Материнские платы",
  "products": [
    {
      "name": "ASUS ROG MAXIMUS X HERO",
      "description": "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX",
      "price": "19310.00",
      "createded_at": "2020-08-01 22:17:36"
    },
    {
      "name": "Gigabyte H310M S2H",
      "description": "H310M S2H, H310, Socket 1151-V2, DDR4, mATX",
      "price": "4790.00",
      "createded_at": "2020-08-01 22:17:36"
    },
    {
      "name": "MSI B250M GAMING PRO",
      "description": "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX",
      "price": "5060.00",
      "createded_at": "2020-08-01 22:17:36"
    }
  ]
}
{
  "_id": "6035359915299e001ff486ac",
  "category": "Видеокарты"
}
{
  "_id": "6035359a15299e001ff486ad",
  "category": "Жесткие диски"
}
{
  "_id": "6035359b15299e001ff486ae",
  "category": "Оперативная память"
}
*/
