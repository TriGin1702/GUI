    function toast1({

    }) {
        const main = document.getElementById('toast1');
        if (main) {
            const toast1 = document.createElement('div');
            toast1.classList.add('toast1');
            // auto remove
            // click remove
            toast1.onclick = function(e) {
                if (e.target.closest('.auth-form_control-back')) {
                    main.removeChild(toast1);
                }
            }
            toast1.style.animation = `fadein ease .05s, forwards`;
            toast1.innerHTML = `
        <div class="modal">
        <div class="modal_overplay">

        </div>
        <div class="modal_body">
            <div class="auth-form">
                <div class="auth-form_header">
                    <span class="auth-form_login">Đăng ký</span>
                </div>
                <div class="auth-form_group">
                    <input type="text" class="auth-form_input" placeholder="your email">
                </div>
                <div class="auth-form_group">
                    <input type="password" class="auth-form_input" placeholder="your password">
                </div>
                <div class="auth-form_group">
                    <input type="password" class="auth-form_input" placeholder="your password again">
                </div>
                <div auth-form_aside>
                    <p class="auth-form_text">từ đăng ký bạn đã đồng ý về
                        <a href="" class="auth-form_link">điều khoản dịch vụ</a>
                    </p>
                </div>
                <div class="auth-form_controls">
                    <button class="btn btn-normal auth-form_control-back">RETURN</button>
                    <button class="btn btn--primary">ĐĂNG KÝ</button>
                </div>
            </div>
        </div>
    </div>
  `;
            main.appendChild(toast1);
        }
    }

    function showSuccessToast1() {
        toast1({});
    }


    function toast2({

    }) {
        const main = document.getElementById('toast2');
        if (main) {
            const toast2 = document.createElement('div');
            toast2.classList.add('toast2');
            // auto remove
            // click remove
            toast2.onclick = function(e) {
                if (e.target.closest('.auth-form_control-back')) {
                    main.removeChild(toast2);
                }
            }
            toast2.style.animation = `fadein ease .05s, forwards`;
            toast2.innerHTML = `
        <div class="modal">
        <div class="modal_overplay">

        </div>
        <div class="modal_body">
            <div class="auth-form">
                <div class="auth-form_header">
                    <span class="auth-form_switch">Đăng nhập</span>
                </div>
                <div class="auth-form_group">
                    <input type="text" class="auth-form_input" placeholder="your email">
                </div>
                <div class="auth-form_group">
                    <input type="password" class="auth-form_input" placeholder="your password">
                </div>
                <div class="auth-form_aside">
                    <div class="auth-form_help">
                        <a href="" class="auth-form_help-link">Quên mật khẩu</a>
                        <span class="auth-form_help-space"></span>
                        <a href="" class="auth-form_help-link">Cần trợ giúp?</a>
                    </div>
                </div>
                <div class="auth-form_controls">
                    <button class="btn btn-normal auth-form_control-back">RETURN</button>
                    <button class="btn btn--primary">ĐĂNG NHẬP</button>
                </div>
            </div>
        </div>
    </div>
  `;
            main.appendChild(toast2);
        }
    }

    function showSuccessToast2() {
        toast2({});
    }




    // buttoncart
    function toast({ title = '', message = '', type = 'info', duration = 3000 }) {
        const main = document.getElementById('toast');
        console.log(title);
        if (main) {
            const toast = document.createElement('div');

            // Auto remove toast
            const autoRemoveId = setTimeout(function() {
                main.removeChild(toast);
            }, duration + 1000);

            // Remove toast when clicked
            toast.onclick = function(e) {
                if (e.target.closest('.toast__close')) {
                    main.removeChild(toast);
                    clearTimeout(autoRemoveId);
                }
            };

            const icons = {
                success: 'fas fa-check-circle',
                info: 'bi bi-info-circle-fill',
                warning: 'bi bi-exclamation-circle-fill',
                error: 'bi bi-bug-fill',
            };
            const icon = icons[type];
            const delay = (duration / 1000).toFixed(2);

            toast.classList.add('toast', `toast--${type}`);
            toast.style.animation = `slideInLeft ease .3s, fadeOut linear 1s ${delay}s forwards`;

            toast.innerHTML = `
                          <div class="toast__icon">
                              <i class="${icon}"></i>
                          </div>
                          <div class="toast__body">
                              <h3 class="toast__title">${title}</h3>
                              <p class="toast__msg">${message}</p>
                          </div>
                          <div class="toast__close">
                              <i class="fas fa-times"></i>
                          </div>
                      `;
            main.appendChild(toast);
        }
    }

    async function showSuccessToast(event) {
        event.preventDefault();

        // Lấy thông tin sản phẩm
        try {

            // Xử lý phản hồi thành công
            toast({
                title: 'Thành công!',
                message: 'Bạn đã thêm sản phẩm vào giỏ hàng thành công!',
                type: 'success',
                duration: 5000,
            });

        } catch (error) {
            // Xử lý lỗi
            toast({
                title: 'Lỗi!',
                message: 'Đã xảy ra lỗi khi thêm sản phẩm vào giỏ hàng. Vui lòng thử lại sau!',
                type: 'error',
                duration: 5000,
            });
        }
    }