// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    product_id: "E101",
    name: "Samsung 55-inch 4K Smart TV",
    category: "Electronics",
    brand: "Samsung",
    price: 45999,
    specifications: {
      screen_size: "55 inch",
      resolution: "4K UHD",
      warranty_years: 2,
      voltage: "220-240V"
    },
    features: ["Smart TV", "WiFi", "HDR", "Voice Control"],
    stock: 25
  },
  {
    product_id: "C201",
    name: "Men's Casual Cotton Shirt",
    category: "Clothing",
    brand: "Levis",
    price: 1899,
    sizes: ["S", "M", "L", "XL"],
    colors: ["Blue", "White", "Black"],
    material: "100% Cotton",
    care_instructions: {
      wash: "Machine wash",
      iron: "Medium heat"
    },
    stock: 60
  },
  {
    product_id: "G301",
    name: "Organic Whole Milk",
    category: "Groceries",
    brand: "Amul",
    price: 72,
    expiry_date: new Date("2024-12-20"),
    nutritional_info: {
      calories: 150,
      protein_g: 8,
      fat_g: 8,
      carbs_g: 12
    },
    storage: "Keep refrigerated",
    stock: 120
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: new Date("2025-01-01") }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { product_id: "E101" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });

// This index improves query performance for searches filtered by category,
// such as retrieving all Electronics or all Groceries products.
