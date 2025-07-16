// Global Variables
let products = [];
let cart = [];
let filteredProducts = [];
let nextId = 1;

// Sample Products Data
const sampleProducts = [
    {
        id: 1,
        name: "هاتف ذكي Samsung Galaxy",
        description: "هاتف ذكي متطور بكاميرا عالية الجودة وأداء ممتاز",
        price: 45000,
        category: "إلكترونيات",
        image: "data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 300 200'><rect width='300' height='200' fill='%23667eea'/><text x='150' y='100' text-anchor='middle' fill='white' font-size='20' font-family='Arial'>Samsung Galaxy</text></svg>",
        stock: 15,
        featured: true
    },
    {
        id: 2,
        name: "لابتوب HP Pavilion",
        description: "لابتوب قوي للعمل والدراسة مع معالج سريع وذاكرة كبيرة",
        price: 85000,
        category: "إلكترونيات",
        image: "data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 300 200'><rect width='300' height='200' fill='%23764ba2'/><text x='150' y='100' text-anchor='middle' fill='white' font-size='20' font-family='Arial'>HP Pavilion</text></svg>",
        stock: 8,
        featured: true
    },
    {
        id: 3,
        name: "ساعة ذكية Apple Watch",
        description: "ساعة ذكية متطورة لتتبع الصحة واللياقة البدنية",
        price: 32000,
        category: "إكسسوارات",
        image: "data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 300 200'><rect width='300' height='200' fill='%23FFD700'/><text x='150' y='100' text-anchor='middle' fill='%23333' font-size='18' font-family='Arial'>Apple Watch</text></svg>",
        stock: 20,
        featured: false
    },
    {
        id: 4,
        name: "سماعات Bluetooth",
        description: "سماعات لاسلكية عالية الجودة مع إلغاء الضوضاء",
        price: 12000,
        category: "إكسسوارات",
        image: "data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 300 200'><rect width='300' height='200' fill='%2328a745'/><text x='150' y='95' text-anchor='middle' fill='white' font-size='16' font-family='Arial'>Bluetooth</text><text x='150' y='115' text-anchor='middle' fill='white' font-size='16' font-family='Arial'>Headphones</text></svg>",
        stock: 25,
        featured: false
    },
    {
        id: 5,
        name: "كاميرا Canon DSLR",
        description: "كاميرا احترافية للتصوير الفوتوغرافي والفيديو",
        price: 95000,
        category: "كاميرات",
        image: "data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 300 200'><rect width='300' height='200' fill='%23dc3545'/><text x='150' y='100' text-anchor='middle' fill='white' font-size='20' font-family='Arial'>Canon DSLR</text></svg>",
        stock: 5,
        featured: true
    },
    {
        id: 6,
        name: "تابلت iPad",
        description: "تابلت متطور للعمل والترفيه مع شاشة عالية الدقة",
        price: 55000,
        category: "إلكترونيات",
        image: "data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 300 200'><rect width='300' height='200' fill='%2317a2b8'/><text x='150' y='100' text-anchor='middle' fill='white' font-size='24' font-family='Arial'>iPad</text></svg>",
        stock: 12,
        featured: false
    }
];

// Initialize App
document.addEventListener('DOMContentLoaded', function() {
    loadProducts();
    loadCart();
    setupEventListeners();
    updateCategoryFilter();
    displayProducts();
    updateCartUI();
});

// Load Products
function loadProducts() {
    const savedProducts = localStorage.getItem('variteks_products');
    if (savedProducts) {
        try {
            products = JSON.parse(savedProducts);
            nextId = Math.max(...products.map(p => p.id), 0) + 1;
        } catch (error) {
            console.error('خطأ في تحميل المنتجات:', error);
            products = sampleProducts;
            nextId = 7;
        }
    } else {
        products = sampleProducts;
        nextId = 7;
        localStorage.setItem('variteks_products', JSON.stringify(products));
    }
    filteredProducts = [...products];
}

// Save Products
function saveProducts() {
    localStorage.setItem('variteks_products', JSON.stringify(products));
    localStorage.setItem('variteks_products_timestamp', Date.now().toString());
}

// Load Cart
function loadCart() {
    const savedCart = localStorage.getItem('variteks_cart');
    if (savedCart) {
        try {
            cart = JSON.parse(savedCart);
        } catch (error) {
            console.error('خطأ في تحميل السلة:', error);
            cart = [];
        }
    }
}

// Save Cart
function saveCart() {
    localStorage.setItem('variteks_cart', JSON.stringify(cart));
}

// Setup Event Listeners
function setupEventListeners() {
    // Search
    document.getElementById('searchInput').addEventListener('input', function() {
        applyFilters();
    });

    // Filter inputs
    document.getElementById('categoryFilter').addEventListener('change', applyFilters);
    document.getElementById('priceMin').addEventListener('input', applyFilters);
    document.getElementById('priceMax').addEventListener('input', applyFilters);
    document.getElementById('sortBy').addEventListener('change', applyFilters);

    // Product form
    document.getElementById('productForm').addEventListener('submit', function(e) {
        e.preventDefault();
        addProduct();
    });

    // Close cart when clicking outside
    document.addEventListener('click', function(e) {
        const cartSidebar = document.getElementById('cartSidebar');
        const cartButton = e.target.closest('[onclick="toggleCart()"]');
        
        if (!cartSidebar.contains(e.target) && !cartButton && cartSidebar.classList.contains('open')) {
            toggleCart();
        }
    });

    // Close admin panel when clicking outside
    document.addEventListener('click', function(e) {
        const adminPanel = document.getElementById('adminPanel');
        const adminContent = document.querySelector('.admin-content');
        const adminButton = e.target.closest('[onclick="openAdminPanel()"]');
        
        if (adminPanel.classList.contains('open') && !adminContent.contains(e.target) && !adminButton) {
            closeAdminPanel();
        }
    });
}

// Update Category Filter
function updateCategoryFilter() {
    const categoryFilter = document.getElementById('categoryFilter');
    const categories = [...new Set(products.map(product => product.category))];
    
    categoryFilter.innerHTML = '<option value="">جميع الفئات</option>';
    categories.forEach(category => {
        const option = document.createElement('option');
        option.value = category;
        option.textContent = category;
        categoryFilter.appendChild(option);
    });
}

// Display Products
function displayProducts() {
    const productsGrid = document.getElementById('productsGrid');
    const loading = document.getElementById('loading');
    const emptyState = document.getElementById('emptyState');
    const productsCount = document.getElementById('productsCount');

    // Show loading
    loading.style.display = 'block';
    productsGrid.style.display = 'none';
    emptyState.style.display = 'none';

    // Simulate loading delay
    setTimeout(() => {
        loading.style.display = 'none';
        
        if (filteredProducts.length === 0) {
            emptyState.style.display = 'block';
            productsCount.textContent = '0';
            return;
        }

        productsGrid.style.display = 'grid';
        productsGrid.innerHTML = '';
        
        filteredProducts.forEach(product => {
            const productCard = createProductCard(product);
            productsGrid.appendChild(productCard);
        });

        productsCount.textContent = filteredProducts.length;
    }, 500);
}

// Create Product Card
function createProductCard(product) {
    const card = document.createElement('div');
    card.className = 'product-card';
    
    card.innerHTML = `
        <img src="${product.image}" alt="${product.name}" class="product-image" 
             onerror="this.src='data:image/svg+xml,<svg xmlns=\\'http://www.w3.org/2000/svg\\' viewBox=\\'0 0 300 200\\'><rect width=\\'300\\' height=\\'200\\' fill=\\'%23f8f9fa\\'/><text x=\\'150\\' y=\\'100\\' text-anchor=\\'middle\\' fill=\\'%23666\\' font-size=\\'16\\' font-family=\\'Arial\\'>صورة غير متوفرة</text></svg>'">
        <div class="product-info">
            <h3 class="product-name">${product.name}</h3>
            <p class="product-description">${product.description}</p>
            <div class="product-price">${product.price.toLocaleString()} دج</div>
            <div style="margin-bottom: 1rem;">
                <small style="color: #666;">
                    <span class="fa fa-box"></span> متوفر: ${product.stock} قطعة
                </small>
            </div>
            <div class="product-actions">
                <button class="btn btn-primary btn-small" onclick="addToCart(${product.id})">
                    <span class="fa fa-cart-plus"></span> أضف للسلة
                </button>
                <button class="btn btn-secondary btn-small" onclick="viewProduct(${product.id})">
                    <span class="fa fa-eye"></span> عرض
                </button>
            </div>
        </div>
    `;
    
    return card;
}

// Apply Filters
function applyFilters() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const category = document.getElementById('categoryFilter').value;
    const priceMin = parseFloat(document.getElementById('priceMin').value) || 0;
    const priceMax = parseFloat(document.getElementById('priceMax').value) || Infinity;
    const sortBy = document.getElementById('sortBy').value;

    filteredProducts = products.filter(product => {
        const matchesSearch = product.name.toLowerCase().includes(searchTerm) || 
                            product.description.toLowerCase().includes(searchTerm);
        const matchesCategory = !category || product.category === category;
        const matchesPrice = product.price >= priceMin && product.price <= priceMax;
        
        return matchesSearch && matchesCategory && matchesPrice;
    });

    // Sort products
    switch (sortBy) {
        case 'price-low':
            filteredProducts.sort((a, b) => a.price - b.price);
            break;
        case 'price-high':
            filteredProducts.sort((a, b) => b.price - a.price);
            break;
        case 'newest':
            filteredProducts.sort((a, b) => b.id - a.id);
            break;
        default:
            filteredProducts.sort((a, b) => a.name.localeCompare(b.name));
    }

    displayProducts();
}

// Clear Filters
function clearFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('categoryFilter').value = '';
    document.getElementById('priceMin').value = '';
    document.getElementById('priceMax').value = '';
    document.getElementById('sortBy').value = 'name';
    
    filteredProducts = [...products];
    displayProducts();
}

// Add to Cart
function addToCart(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) {
        showNotification('المنتج غير موجود!', 'error');
        return;
    }

    if (product.stock <= 0) {
        showNotification('المنتج غير متوفر في المخزن!', 'error');
        return;
    }

    const existingItem = cart.find(item => item.id === productId);
    if (existingItem) {
        if (existingItem.quantity >= product.stock) {
            showNotification('لا يمكن إضافة المزيد من هذا المنتج!', 'error');
            return;
        }
        existingItem.quantity += 1;
    } else {
        cart.push({
            id: product.id,
            name: product.name,
            price: product.price,
            image: product.image,
            quantity: 1
        });
    }

    saveCart();
    updateCartUI();
    showNotification('تم إضافة المنتج للسلة!', 'success');
}

// Remove from Cart
function removeFromCart(productId) {
    cart = cart.filter(item => item.id !== productId);
    saveCart();
    updateCartUI();
    showNotification('تم حذف المنتج من السلة!', 'info');
}

// Update Cart Quantity
function updateCartQuantity(productId, quantity) {
    const item = cart.find(item => item.id === productId);
    if (item) {
        const product = products.find(p => p.id === productId);
        if (quantity <= 0) {
            removeFromCart(productId);
        } else if (quantity <= product.stock) {
            item.quantity = quantity;
            saveCart();
            updateCartUI();
        } else {
            showNotification('الكمية المطلوبة غير متوفرة!', 'error');
        }
    }
}

// Update Cart UI
function updateCartUI() {
    const cartCount = document.getElementById('cartCount');
    const cartItems = document.getElementById('cartItems');
    const cartTotal = document.getElementById('cartTotal');

    // Update cart count
    const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
    cartCount.textContent = totalItems;

    // Update cart items
    if (cart.length === 0) {
        cartItems.innerHTML = `
            <div class="empty-state">
                <span class="fa fa-shopping-cart"></span>
                <h4>السلة فارغة</h4>
                <p>لم تقم بإضافة أي منتجات بعد</p>
            </div>
        `;
    } else {
        cartItems.innerHTML = cart.map(item => `
            <div class="cart-item">
                <img src="${item.image}" alt="${item.name}"
                     onerror="this.src='data:image/svg+xml,<svg xmlns=\\'http://www.w3.org/2000/svg\\' viewBox=\\'0 0 60 60\\'><rect width=\\'60\\' height=\\'60\\' fill=\\'%23f8f9fa\\'/><text x=\\'30\\' y=\\'30\\' text-anchor=\\'middle\\' fill=\\'%23666\\' font-size=\\'10\\' font-family=\\'Arial\\'>صورة</text></svg>'">
                <div class="cart-item-info">
                    <h4>${item.name}</h4>
                    <p>${item.price.toLocaleString()} دج</p>
                    <div style="display: flex; align-items: center; gap: 0.5rem; margin-top: 0.5rem;">
                        <button onclick="updateCartQuantity(${item.id}, ${item.quantity - 1})"
                                style="background: #dc3545; color: white; border: none; border-radius: 4px; width: 25px; height: 25px; cursor: pointer;">-</button>
                        <span>${item.quantity}</span>
                        <button onclick="updateCartQuantity(${item.id}, ${item.quantity + 1})"
                                style="background: #28a745; color: white; border: none; border-radius: 4px; width: 25px; height: 25px; cursor: pointer;">+</button>
                    </div>
                </div>
                <button onclick="removeFromCart(${item.id})"
                        style="background: #dc3545; color: white; border: none; border-radius: 4px; padding: 0.5rem; cursor: pointer;">
                    <span class="fa fa-trash"></span>
                </button>
            </div>
        `).join('');
    }

    // Update total
    const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    cartTotal.textContent = total.toLocaleString();
}

// Toggle Cart
function toggleCart() {
    const cartSidebar = document.getElementById('cartSidebar');
    cartSidebar.classList.toggle('open');
}

// Clear Cart
function clearCart() {
    if (cart.length === 0) {
        showNotification('السلة فارغة بالفعل!', 'info');
        return;
    }

    if (confirm('هل أنت متأكد من مسح جميع المنتجات من السلة؟')) {
        cart = [];
        saveCart();
        updateCartUI();
        showNotification('تم مسح السلة!', 'info');
    }
}

// Checkout
function checkout() {
    if (cart.length === 0) {
        showNotification('السلة فارغة! أضف منتجات أولاً', 'error');
        return;
    }

    const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    const orderDetails = cart.map(item => `${item.name} (${item.quantity}x)`).join('\n');

    const message = `طلب جديد من متجر Variteks-Algérie:\n\n${orderDetails}\n\nالمجموع: ${total.toLocaleString()} دج\n\nيرجى التواصل معنا لتأكيد الطلب.`;

    // WhatsApp link
    const whatsappNumber = '213XXXXXXXXX'; // استبدل بالرقم الحقيقي
    const whatsappUrl = `https://wa.me/${whatsappNumber}?text=${encodeURIComponent(message)}`;

    // Open WhatsApp
    window.open(whatsappUrl, '_blank');

    showNotification('تم توجيهك لإتمام الطلب عبر WhatsApp!', 'success');
}

// View Product
function viewProduct(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) return;

    alert(`${product.name}\n\n${product.description}\n\nالسعر: ${product.price.toLocaleString()} دج\nالمتوفر: ${product.stock} قطعة\nالفئة: ${product.category}`);
}

// Admin Panel Functions
function openAdminPanel() {
    document.getElementById('adminPanel').classList.add('open');
    updateAdminProductsList();
}

function closeAdminPanel() {
    document.getElementById('adminPanel').classList.remove('open');
}

// Add Product (Admin)
function addProduct() {
    const name = document.getElementById('productName').value.trim();
    const category = document.getElementById('productCategory').value;
    const description = document.getElementById('productDescription').value.trim();
    const price = parseFloat(document.getElementById('productPrice').value);
    const stock = parseInt(document.getElementById('productStock').value);
    const image = document.getElementById('productImage').value.trim();

    // Validation
    if (!name || !category || !description || !price || !stock) {
        showNotification('يرجى ملء جميع الحقول المطلوبة!', 'error');
        return;
    }

    if (price <= 0) {
        showNotification('السعر يجب أن يكون أكبر من صفر!', 'error');
        return;
    }

    if (stock < 0) {
        showNotification('الكمية لا يمكن أن تكون سالبة!', 'error');
        return;
    }

    // Create product
    const product = {
        id: nextId++,
        name: name,
        category: category,
        description: description,
        price: price,
        stock: stock,
        image: image || `data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 300 200'><rect width='300' height='200' fill='%23667eea'/><text x='150' y='100' text-anchor='middle' fill='white' font-size='16' font-family='Arial'>${encodeURIComponent(name)}</text></svg>`,
        featured: false,
        createdAt: new Date().toISOString()
    };

    // Add to products array
    products.push(product);

    // Save and sync
    saveProducts();
    updateCategoryFilter();
    applyFilters();
    clearForm();
    updateAdminProductsList();

    showNotification('تم إضافة المنتج بنجاح!', 'success');
}

// Clear Form
function clearForm() {
    document.getElementById('productForm').reset();
}

// Update Admin Products List
function updateAdminProductsList() {
    const adminProductsList = document.getElementById('adminProductsList');
    const adminProductsCount = document.getElementById('adminProductsCount');

    adminProductsCount.textContent = products.length;

    if (products.length === 0) {
        adminProductsList.innerHTML = `
            <div style="text-align: center; padding: 2rem; color: #666;">
                <span class="fa fa-box-open" style="font-size: 2rem; margin-bottom: 1rem; color: #ddd;"></span>
                <h4>لا توجد منتجات</h4>
                <p>ابدأ بإضافة منتجات جديدة</p>
            </div>
        `;
        return;
    }

    adminProductsList.innerHTML = products.map(product => `
        <div style="display: flex; align-items: center; gap: 1rem; padding: 1rem; border: 1px solid #eee; border-radius: 8px; margin-bottom: 1rem;">
            <img src="${product.image}" alt="${product.name}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;"
                 onerror="this.src='data:image/svg+xml,<svg xmlns=\\'http://www.w3.org/2000/svg\\' viewBox=\\'0 0 50 50\\'><rect width=\\'50\\' height=\\'50\\' fill=\\'%23f8f9fa\\'/><text x=\\'25\\' y=\\'25\\' text-anchor=\\'middle\\' fill=\\'%23666\\' font-size=\\'8\\' font-family=\\'Arial\\'>صورة</text></svg>'">
            <div style="flex: 1;">
                <h4 style="margin: 0; font-size: 0.9rem;">${product.name}</h4>
                <p style="margin: 0; color: #666; font-size: 0.8rem;">${product.price.toLocaleString()} دج - متوفر: ${product.stock}</p>
                <span style="background: var(--info-color); color: white; padding: 0.2rem 0.4rem; border-radius: 4px; font-size: 0.7rem;">
                    ${product.category}
                </span>
            </div>
            <div style="display: flex; gap: 0.5rem;">
                <button onclick="editProduct(${product.id})" style="background: var(--warning-color); color: white; border: none; border-radius: 4px; padding: 0.5rem; cursor: pointer; font-size: 0.8rem;">
                    <span class="fa fa-edit"></span>
                </button>
                <button onclick="deleteProduct(${product.id})" style="background: var(--danger-color); color: white; border: none; border-radius: 4px; padding: 0.5rem; cursor: pointer; font-size: 0.8rem;">
                    <span class="fa fa-trash"></span>
                </button>
            </div>
        </div>
    `).join('');
}

// Edit Product
function editProduct(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) return;

    // Fill form with product data
    document.getElementById('productName').value = product.name;
    document.getElementById('productCategory').value = product.category;
    document.getElementById('productDescription').value = product.description;
    document.getElementById('productPrice').value = product.price;
    document.getElementById('productStock').value = product.stock;
    document.getElementById('productImage').value = product.image;

    // Remove product from array (will be re-added when form is submitted)
    products = products.filter(p => p.id !== productId);
    saveProducts();
    updateCategoryFilter();
    applyFilters();
    updateAdminProductsList();

    showNotification('تم تحميل بيانات المنتج للتعديل', 'info');
}

// Delete Product
function deleteProduct(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) return;

    if (confirm(`هل أنت متأكد من حذف المنتج "${product.name}"؟`)) {
        products = products.filter(p => p.id !== productId);
        saveProducts();
        updateCategoryFilter();
        applyFilters();
        updateAdminProductsList();
        showNotification('تم حذف المنتج بنجاح!', 'success');
    }
}

// Show Notification
function showNotification(message, type = 'info') {
    const notification = document.getElementById('notification');
    notification.textContent = message;
    notification.className = `notification ${type}`;
    notification.classList.add('show');

    setTimeout(() => {
        notification.classList.remove('show');
    }, 3000);
}

// Auto-sync monitoring
function startSyncMonitoring() {
    // Listen for localStorage changes
    window.addEventListener('storage', (e) => {
        if (e.key === 'variteks_products') {
            console.log('🔄 تم اكتشاف تحديث في المنتجات');
            loadProducts();
            updateCategoryFilter();
            applyFilters();
            showNotification('تم تحديث المنتجات!', 'success');
        }
    });

    // Periodic check for updates
    setInterval(() => {
        const currentProducts = localStorage.getItem('variteks_products');
        if (currentProducts) {
            try {
                const newProducts = JSON.parse(currentProducts);
                if (JSON.stringify(newProducts) !== JSON.stringify(products)) {
                    loadProducts();
                    updateCategoryFilter();
                    applyFilters();
                    showNotification('تم تحديث المنتجات!', 'success');
                }
            } catch (error) {
                console.error('خطأ في فحص التحديثات:', error);
            }
        }
    }, 2000);
}

// Start sync monitoring
startSyncMonitoring();
