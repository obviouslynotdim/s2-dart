enum DeliveryType { PICKUP, DELIVERY }

class Product {
  String name;
  double price;

  Product({required this.name, required this.price});

  Product.food({required String name, required double price})
    : this.name = name,
      this.price = price;

  void display() {
    print('Product: $name | Price: \$${price}');
  }
}

class OrderItem {
  Product product;
  int quantity;

  OrderItem({required this.product, required this.quantity});

  double get subtotal => product.price * quantity; // readable subtotal
}

class Customer {
  String name;

  Customer({required this.name});
}

class Order {
  Customer customer;
  List<OrderItem> items;
  DeliveryType type;
  String? address; // nullable

  Order({
    required this.customer,
    required this.items,
    required this.type,
    this.address, // optional for pickup
  });

  double get total {
    double sum = 0;
    for (var item in items) sum += item.subtotal;
    if (type == DeliveryType.DELIVERY) sum += 5; // delivery fee
    return sum;
  }

  void printOrder() {
    print('=== Order Details ===');
    print("Customer: ${customer.name}");
    print("Order Type: $type");
    if (type == DeliveryType.DELIVERY) {
      print("Adress: $address");
    }
    print("items:");
    for (var item in items) {
      print("- ${item.product.name} x ${item.quantity} = \$${item.subtotal}");
    }
    print("Total Amount: \$${total}");
    print('---------------------');
  }
}

void main() {
  var c1 = Customer(name: "Dim");
  var c2 = Customer(name: "Sal");

  var p1 = Product(name: "Boba", price: 10);
  var p2 = Product.food(name: "Cake", price: 25);
  var p3 = Product(name: "Matcha", price: 15);

  var order1 = Order(
    customer: c1,
    items: [OrderItem(product: p1, quantity: 2)],
    type: DeliveryType.DELIVERY,
    address: '6767 Phnom Penh',
  );

  var order2 = Order(
    customer: c2,
    items: [
      OrderItem(product: p2, quantity: 3),
      OrderItem(product: p3, quantity: 1),
    ],
    type: DeliveryType.PICKUP,
  );

  order1.printOrder();
  order2.printOrder();
}
