class AppConstant {
  static const String baseUrl = "https://sposversion2.extraaaz.com/api";
//var baseUrl = "http://192.168.1.109:8000/api";

  static const String supportURL = "https://wa.me/919499888170";
  static const String loginUrl = "userlogin";
  static const String registerUrl = "userregister";
  static const String currency = "₹";
  static const String item = "category"; // original
  static const String floorTables = "getFloorsAndTables";
  static const String dashboardDetails = "dashboard-cards";
  static const String topSelling = "top-selling-items";
  static const String getrunningkot = "getrunningkot";
  static const String cart = "order-confirm";
  static const String invoices = "getBillingDetails"; //invoice
  static const String category = "category"; //category
  static const String currentOrder = "getbookedtables"; //CurrentOrder
  static const String modifierbyId = "modifer";
  static const String dineId = "getTableId/Dine-In";
  static const String takeAwayID = "getTableId/TakeAway";
  static const String advanced = "getTableId/Advance";
  static const String pendingAdvance = "getTotalOrders/Advance";
  static const String completeOrder = "complete-order";
  static const String cancelOrder = "cancel-order";
  static const String onlinePayment = "online-payment";
  static const String cashPayment = "cash-payment";
  static const String activeTable = "getActiveTables";
  static const String updateItem = "update-item";
  static const String cancelItem = "cancel-item";

// Reports -------------------------->
  static const String cashierReport = "cashier-report";
  static const String cashierWiseReport = "cashier-role-report";
  static const String dayReport = "day-summary-report";
  static const String soldItemTotal = "itemtotalreport";
  static const String cancelOrderReport = "cancel-order-report";

// Floors, Section, Tables Constants--------->
  static const String graph = "graph";

// ModifiersGroups Constants ---------------------->
  static const String modifier = "modifierGroups";
  static const String showModifierItems = "showItems";
  static const String showModifiers = "showModifiers";
  static const String selectModifiers = "selectModifiers";
  static const String saveModifiers = "saveModifiers";
  static const String saveItems = "saveItems";
  static const String selectItems = "selectItems";

// Modifiers Constants-------------->
  static const String addmodifiers = "modifiers";

  static const String itemSalesReport = "itemsale";

// Customer Details-------------->
  static const String customerlist = "customer";
  static const String customerAddress = "getCustomerAddresses";
  static const String multipleAddress = "customerAddress";

// Show Modifiers---------------->
  static const String orderbookingmodifiers = "showModifierGroups";

//Delivery Order--------------------->
  static const String delivery = "getTotalOrders/Delivery";
  static const String outForDelivery = "getDeliveryPendingOrders";
  static const String updateStatusForDelivery = "update-status-delivery";
  static const String deliveryCompletedOrders = "getDeliveryCompletedOrders";

//Update Restaurant-------------->
  static const String updateRestaurantAPI = "updateRestaurant"; //used

// On going Order------------------>
  static const String onGoingOrder = "get-ongoing-orders";


//Taxes----------------->
  static const String taxes = "tax-setting";
  static const String gettaxes = "get-tax";

//Table Transfer--------------->
  static const String transfer = "table-transfer";

// Inventory------------------->
static const String inventoryList = 'inventory';
static const String createSupplier = "create-supplier";
static const String getSupplier = "supplier-list";
static const String suppliers = "suppliers";
static const String purchaseList = "purchase-list";
static const String createPurchase = "create-purchase";
static const String deletePurchase = "purchase-orders";
static const String viewStatement = "view-statement";
static const String addPayment = "add-payment";
static const String returnStock = "return-stock";

static const String invcredit = "inv-credit";

//recipe
static const String ingredientList = "ingredient-list";
static const String recipeList = "recipe-list";
static const String createRecipe = "create-recipe"; 
static const String setThreshold = "set-threshold"; 

static const String setThresoldValue = "ingredient/threshold-value";


// credit 
static const String creditCard = "pay-outstanding/";

}
