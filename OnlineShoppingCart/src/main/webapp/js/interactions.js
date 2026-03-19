document.addEventListener('DOMContentLoaded', () => {
    // Custom Cursor
    const dot = document.createElement('div');
    dot.id = 'cursor-dot';
    const ring = document.createElement('div');
    ring.id = 'cursor-ring';
    document.body.appendChild(dot);
    document.body.appendChild(ring);

    let mouseX = 0, mouseY = 0, ringX = 0, ringY = 0;
    
    document.addEventListener('mousemove', e => {
        mouseX = e.clientX;
        mouseY = e.clientY;
    });

    document.addEventListener('mousedown', () => document.body.classList.add('cursor-click'));
    document.addEventListener('mouseup', () => document.body.classList.remove('cursor-click'));

    // Apply cursor classes based on what's hovered
    document.querySelectorAll('a, button, .interactive').forEach(el => {
        el.addEventListener('mouseenter', () => document.body.classList.add('cursor-hover-btn'));
        el.addEventListener('mouseleave', () => document.body.classList.remove('cursor-hover-btn'));
    });

    document.querySelectorAll('.product-card').forEach(el => {
        el.addEventListener('mouseenter', () => document.body.classList.add('cursor-hover-card'));
        el.addEventListener('mouseleave', () => document.body.classList.remove('cursor-hover-card'));
    });

    function lerp(a, b, t) { return a + (b - a) * t; }
    function animateCursor() {
        ringX = lerp(ringX, mouseX, 0.12);
        ringY = lerp(ringY, mouseY, 0.12);
        ring.style.left = ringX + 'px';
        ring.style.top = ringY + 'px';
        dot.style.left = mouseX + 'px';
        dot.style.top = mouseY + 'px';
        requestAnimationFrame(animateCursor);
    }
    animateCursor();

    // Navbar Scroll Effect
    const navbar = document.querySelector('.navbar');
    if (navbar) {
        window.addEventListener('scroll', () => {
            if (window.scrollY > 80) navbar.classList.add('scrolled');
            else navbar.classList.remove('scrolled');
        });
    }

    // 3D Card Tilt Effect
    document.querySelectorAll('.product-card').forEach(card => {
        card.addEventListener('mousemove', e => {
            const rect = card.getBoundingClientRect();
            const x = (e.clientX - rect.left) / rect.width - 0.5;
            const y = (e.clientY - rect.top) / rect.height - 0.5;
            card.style.transform = `perspective(1000px) rotateY(${x * 20}deg) rotateX(${y * -20}deg) scale(1.04)`;
        });
        card.addEventListener('mouseleave', () => {
            card.style.transform = `perspective(1000px) rotateY(0deg) rotateX(0deg) scale(1)`;
        });
    });

    // Wishlist Toggle (AJAX)
    document.querySelectorAll('.btn-wishlist').forEach(btn => {
        btn.addEventListener('click', async (e) => {
            e.preventDefault();
            const pid = btn.dataset.id;
            try {
                // Determine base URL, useful if context path is deep
                const res = await fetch('wishlist', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: `action=toggle&productId=${pid}`
                });
                const data = await res.json();
                if(data.success) {
                    if(data.inWishlist) {
                        btn.classList.add('active');
                        btn.innerHTML = '❤️';
                    } else {
                        btn.classList.remove('active');
                        btn.innerHTML = '🤍';
                    }
                } else {
                    if (data.error === 'Not logged in') {
                        window.location.href = 'login';
                    } else {
                        alert(data.error);
                    }
                }
            } catch (err) { console.error(err); }
        });
    });

    // Add to Cart via AJAX
    window.addToCart = async function(productId, quantity = 1) {
        try {
            const res = await fetch('cart', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: `action=add&productId=${productId}&quantity=${quantity}`
            });
            const data = await res.json();
            if(data.success) {
                // Update cart badge
                const badges = document.querySelectorAll('.cart-badge');
                badges.forEach(b => {
                    b.textContent = data.cartCount;
                    // Add bounce animation styling manually if needed or toggle class
                    b.style.transform = 'scale(1.5)';
                    setTimeout(() => b.style.transform = 'scale(1)', 300);
                });
            } else {
                if(data.error === 'Not logged in') window.location.href = 'login';
                else alert(data.error);
            }
        } catch (err) { console.error(err); }
    };
});
