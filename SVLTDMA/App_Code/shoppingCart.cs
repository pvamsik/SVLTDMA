using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Web;
using System.Data.Entity;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Data.Entity.SqlServer;

namespace CommonDTO
{
    public class CartContext : DbContext
    {
        public CartContext()
            : base("ApplicationServices")
        {
        }
        public DbSet<CartItems> ShoppingCartItems { get; set; }
    }
    /**
     * The Shopping Cart Class
     * 
     * Basically a structure for holding item data
     */
    public class shoppingCart : IDisposable
    {
        public string ShoppingCartId { get; set; }
        private CartContext _db = new CartContext();
        public const string CartSessionKey = "TOMCartId";
        public Data data = new Data();

        /// <summary>
        /// Gets the Services from Application variable 
        /// </summary>
        public List<ServiceDTO> MyServiceList
        {
            get
            {
                return data.GetServices();
            }
        }
        public void Dispose()
        {
            if (_db != null)
            {
                _db.Dispose();
                _db = null;
            }
        }
        public string GetCartId()
        {
            if (HttpContext.Current.Session[CartSessionKey] == null)
            {
                if (!string.IsNullOrWhiteSpace(HttpContext.Current.User.Identity.Name))
                {
                    HttpContext.Current.Session[CartSessionKey] = HttpContext.Current.User.Identity.Name;
                }
                else
                {
                    // Generate a new random GUID using System.Guid class.     
                    Guid tempCartId = Guid.NewGuid();
                    HttpContext.Current.Session[CartSessionKey] = tempCartId.ToString();
                }
            }
            return HttpContext.Current.Session[CartSessionKey].ToString();
        }
        public List<CartItems> GetCartItems()
        {
            ShoppingCartId = GetCartId();

            return _db.ShoppingCartItems.Where(
                c => c.CartId == ShoppingCartId).OrderBy(x => x.orderDate).ToList();
        }
        public void AddToCart(int id, string orderDate)
        {
            // Retrieve the product from the database.           
            ShoppingCartId = GetCartId();

            var cartItem = _db.ShoppingCartItems.SingleOrDefault(
                c => c.CartId == ShoppingCartId && c.Service_ID == id && c.orderDate == orderDate);
            if (cartItem == null)
            {
                cartItem = new CartItems
                {
                    ItemId = Guid.NewGuid().ToString(),
                    CartId = ShoppingCartId,
                    dateCreated = DateTime.Now.ToShortDateString(),
                    orderDate = orderDate,
                    Service_ID = id,
                    comment = "",
                    Service = MyServiceList.Find(st => st.Service_ID == id),
                    Quantity = 1
                };

                _db.ShoppingCartItems.Add(cartItem);
            }
            else
            {
                cartItem.Quantity++;
            }
            _db.SaveChanges();
        }
        public void RemoveFromCart(int id, string orderDate)
        {
            // Retrieve the product from the database.           
            ShoppingCartId = GetCartId();

            var cartItem = _db.ShoppingCartItems.SingleOrDefault(
                c => c.CartId == ShoppingCartId && c.Service_ID == id && c.orderDate == orderDate);
            if (cartItem != null)
            {
                _db.ShoppingCartItems.Remove(cartItem);
                _db.SaveChanges();
            }
        }
        public void UpdateShoppingCartDatabase(String cartId, ShoppingCartUpdates[] CartItemUpdates)
        {
            using (var db = new CartContext())
            {
                try
                {
                    int CartItemCount = CartItemUpdates.Count();
                    List<CartItems> myCart = GetCartItems();
                    foreach (var cartItem in myCart)
                    {
                        // Iterate through all rows within shopping cart list
                        for (int i = 0; i < CartItemCount; i++)
                        {
                            if (cartItem.Service_ID == CartItemUpdates[i].Service_Id)
                            {
                                if (CartItemUpdates[i].Quantity < 1)
                                {
                                    RemoveFromCart(cartItem.Service_ID, cartItem.orderDate);
                                }
                                else
                                {
                                    UpdateItem(cartId, CartItemUpdates[i].orderDate, cartItem.Service_ID, CartItemUpdates[i].Quantity, CartItemUpdates[i].price, CartItemUpdates[i].comment);
                                }
                            }
                        }
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Update Cart Database - " + exp.Message.ToString(), exp);
                }
            }
        }
        public void UpdateItem(string updateCartID, string orderDate, int updateProductID, int quantity, decimal price, string comment)
        {
            using (var _db = new CartContext())
            {
                try
                {
                    var myItem = (from c in _db.ShoppingCartItems where c.CartId == updateCartID && c.Service_ID == updateProductID && c.orderDate == orderDate select c).FirstOrDefault();
                    if (myItem != null)
                    {
                        myItem.Quantity = quantity;
                        myItem.Service.Service_Fee = price;
                        myItem.comment = comment;
                        _db.SaveChanges();
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Update Cart Item - " + exp.Message.ToString(), exp);
                }
            }
        }
        public void emptyCart()
        {

            ShoppingCartId = GetCartId();

            var cartItems = _db.ShoppingCartItems.Where(
                c => c.CartId == ShoppingCartId);

            foreach( var cartItem in cartItems)
            {
                _db.ShoppingCartItems.Remove(cartItem);
            }
            _db.SaveChanges();
        }
        public int GetCartCount()
        {
            ShoppingCartId = GetCartId();

            int count = 0;
            foreach (var item in GetCartItems())
            {
                count += item.Quantity;
            }
            //count = _db.ShoppingCartItems.Where(c => c.CartId == ShoppingCartId).ToList().Count;

            return count;
        }
        public decimal GetTotal()
        {
            ShoppingCartId = GetCartId();

            decimal? total = decimal.Zero;
            if(ShoppingCartId != null)
            {
                total = (decimal?)(from CartItems in _db.ShoppingCartItems
                                   where CartItems.CartId == ShoppingCartId
                                   select ((int?)CartItems.Quantity * (double?)CartItems.Service.Service_Fee)).Sum();
            }
            else
            {
                total = decimal.Zero;
            }
            return total ?? decimal.Zero;
        }
        public struct ShoppingCartUpdates
        {
            public string orderDate;
            public int Service_Id;
            public int Quantity;
            public decimal price;
            public string comment;
            public bool RemoveItem;
        }
    }
}