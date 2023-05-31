#!/bin/bash


database_file="products.txt"


create_product() {
  echo "Enter product details:"
  read -p "Product ID: " id
  read -p "Product Name: " name
  read -p "Product Price: " price

 
  if grep -q "^$id|" "$database_file"; then
    echo "Product with ID $id already exists!"
  else
    echo "$id|$name|$price" >> "$database_file"
    echo "Product created successfully!"
  fi
}

#display all products
read_products() {
  if [[ -s "$database_file" ]]; then
    echo "Product ID | Product Name | Price"
    echo "---------------------------------"
    cat "$database_file" | awk -F "|" '{ printf "%-11s| %-13s| $%-7s\n", $1, $2, $3 }'
  else
    echo "No products found."
  fi
}

#update a product
update_product() {
  read -p "Enter the Product ID to update: " id


  if grep -q "^$id|" "$database_file"; then
    echo "Enter new product details:"
    read -p "Product Name: " name
    read -p "Product Price: " price

    
    sed -i "s/^$id|.*/$id|$name|$price/" "$database_file"
    echo "Product updated successfully!"
  else
    echo "Product with ID $id does not exist!"
  fi
}

#delete a product
delete_product() {
  read -p "Enter the Product ID to delete: " id

  # Check if the product exists
  if grep -q "^$id|" "$database_file"; then
    # Remove the product from the database
    sed -i "/^$id|/d" "$database_file"
    echo "Product deleted successfully!"
  else
    echo "Product with ID $id does not exist!"
  fi
}

#Main menu
while true; do
  echo
  echo "*************** E-COMMERCE SITE ***************"
  echo "1. Create Product"
  echo "2. Read Products"
  echo "3. Update Product"
  echo "4. Delete Product"
  echo "5. Exit"
  echo "***********************************************"
  echo

  read -p "Enter your choice (1-5): " choice

  case $choice in
    1)
      create_product
      ;;
    2)
      read_products
      ;;
    3)
      update_product
      ;;
    4)
      delete_product
      ;;
    5)
      echo "Goodbye!"
      exit
      ;;
    *)
      echo "Invalid choice. Please try again."
      ;;
  esac
done
