import './order.scss';
import DefaultLayout from '../../layouts/DefaultLayout';
import { Card } from 'primereact/card';
import { InputText } from 'primereact/inputtext';
import { Button } from 'primereact/button';
import { InputNumber } from 'primereact/inputnumber';
import { useState } from 'react';

interface ProductRow {
  id: number;
  code: string;
  name: string;
  image: string;
  color: string;
  size: string;
  qty_order: number;
  qty_received: number;
  price: number;
  discount: number;
  note: string;
  isEditing?: boolean;
}

const OrderPage = () => {
  const [customerInfo, setCustomerInfo] = useState({
    name: '',
    address: '',
    tax: '',
    phone: '',
    email: '',
    invoice: 'Có',
  });

  const [products, setProducts] = useState<ProductRow[]>([
    {
      id: 1,
      code: 'A001',
      name: 'Áo trắng',
      image: '/shirt1.png',
      color: 'Trắng',
      size: 'L',
      qty_order: 10,
      qty_received: 10,
      price: 300000,
      discount: 0,
      note: '-',
    },
    {
      id: 2,
      code: 'A002',
      name: 'Áo vàng',
      image: '/shirt2.png',
      color: 'Vàng',
      size: 'M',
      qty_order: 5,
      qty_received: 5,
      price: 250000,
      discount: 0,
      note: '-',
    },
  ]);

  const handleChange = (e: any) => {
    const { name, value } = e.target;
    setCustomerInfo({ ...customerInfo, [name]: value });
  };

  const handleAddRow = () => {
    const newRow: ProductRow = {
      id: products.length + 1,
      code: '',
      name: '',
      image: '',
      color: '',
      size: '',
      qty_order: 0,
      qty_received: 0,
      price: 0,
      discount: 0,
      note: '',
      isEditing: true, // cho phép nhập ngay
    };
    setProducts([...products, newRow]);
  };

  const handleDeleteRow = (id: number) => {
    setProducts(products.filter((p) => p.id !== id));
  };

  const handleEditRow = (id: number) => {
    setProducts(products.map((p) => (p.id === id ? { ...p, isEditing: true } : p)));
  };

  const handleSaveRow = (id: number) => {
    setProducts(products.map((p) => (p.id === id ? { ...p, isEditing: false } : p)));
  };

  const handleProductChange = (id: number, field: string, value: any) => {
    setProducts(products.map((p) => (p.id === id ? { ...p, [field]: value } : p)));
  };

  const formatCurrency = (value: number) =>
    value.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });

  const totalAmount = products.reduce(
    (acc, item) => acc + item.price * item.qty_order * (1 - item.discount / 100),
    0,
  );

  const handleSubmit = () => {
    console.log('Thông tin khách hàng:', customerInfo);
    console.log('Chi tiết sản phẩm:', products);
    alert('✅ Đơn hàng đã được xác nhận!');
  };

  return (
    <div className="order-container">
      <div className="grid-container">
        {/* Thông tin khách hàng */}
        <Card className="order-card">
          <h3 className="card-title">Thông tin khách hàng</h3>
          <div className="form-grid">
            <div>
              <label>Tên khách</label>
              <InputText
                name="name"
                value={customerInfo.name}
                onChange={handleChange}
                placeholder="Nhập tên khách hàng..."
              />
            </div>
            <div>
              <label>Địa chỉ</label>
              <InputText
                name="address"
                value={customerInfo.address}
                onChange={handleChange}
                placeholder="Nhập địa chỉ..."
              />
            </div>
            <div>
              <label>Mã số thuế</label>
              <InputText
                name="tax"
                value={customerInfo.tax}
                onChange={handleChange}
                placeholder="Nhập mã số thuế..."
              />
            </div>
            <div>
              <label>Điện thoại</label>
              <InputText
                name="phone"
                value={customerInfo.phone}
                onChange={handleChange}
                placeholder="Nhập số điện thoại..."
              />
            </div>
            <div>
              <label>Email</label>
              <InputText
                name="email"
                value={customerInfo.email}
                onChange={handleChange}
                placeholder="Nhập email..."
              />
            </div>
            <div>
              <label>Lấy hóa đơn</label>
              <select
                name="invoice"
                value={customerInfo.invoice}
                onChange={handleChange}
                className="p-inputtext p-component"
              >
                <option>Có</option>
                <option>Không</option>
              </select>
            </div>
          </div>
        </Card>

        {/* Tổng đơn */}
        <Card className="order-card">
          <h3 className="card-title">Tổng đơn</h3>
          <div className="order-summary">
            <div>
              <span>Xuất hóa đơn:</span>
              <span>200.000₫</span>
            </div>
            <div>
              <span>Tổng giá trị TT:</span>
              <span>{formatCurrency(totalAmount)}</span>
            </div>
            <div>
              <span>Thanh toán lần 1:</span>
              <span>5.000.000₫ (12/02/2025)</span>
            </div>
            <div>
              <span>Thanh toán lần 2:</span>
              <span>2.000.000₫ (12/02/2025)</span>
            </div>
            <div className="font-bold">
              <span>Thanh toán còn lại:</span>
              <span>7.000.000₫</span>
            </div>
          </div>
        </Card>
      </div>

      {/* Chi tiết đơn hàng */}
      <Card className="order-detail-card">
        <h3 className="card-title">Chi tiết đơn hàng</h3>
        <table className="order-table">
          <thead>
            <tr>
              <th>STT</th>
              <th>Mã hàng</th>
              <th>Tên</th>
              <th>Ảnh</th>
              <th>Màu sắc</th>
              <th>Size</th>
              <th>SL đặt</th>
              <th>SL nhận</th>
              <th>Đơn giá</th>
              <th>Chiết khấu</th>
              <th>Thành tiền</th>
              <th>Ghi chú</th>
              <th>Hành động</th>
            </tr>
          </thead>
          <tbody>
            {products.map((item, idx) => (
              <tr key={item.id}>
                <td>{idx + 1}</td>
                {item.isEditing ? (
                  <>
                    <td>
                      <InputText
                        value={item.code}
                        onChange={(e) => handleProductChange(item.id, 'code', e.target.value)}
                      />
                    </td>
                    <td>
                      <InputText
                        value={item.name}
                        onChange={(e) => handleProductChange(item.id, 'name', e.target.value)}
                      />
                    </td>
                    <td>
                      <InputText
                        value={item.image}
                        onChange={(e) => handleProductChange(item.id, 'image', e.target.value)}
                        placeholder="/shirt.png"
                      />
                    </td>
                    <td>
                      <InputText
                        value={item.color}
                        onChange={(e) => handleProductChange(item.id, 'color', e.target.value)}
                      />
                    </td>
                    <td>
                      <InputText
                        value={item.size}
                        onChange={(e) => handleProductChange(item.id, 'size', e.target.value)}
                      />
                    </td>
                    <td>
                      <InputNumber
                        value={item.qty_order}
                        onValueChange={(e) => handleProductChange(item.id, 'qty_order', e.value)}
                      />
                    </td>
                    <td>
                      <InputNumber
                        value={item.qty_received}
                        onValueChange={(e) => handleProductChange(item.id, 'qty_received', e.value)}
                      />
                    </td>
                    <td>
                      <InputNumber
                        value={item.price}
                        onValueChange={(e) => handleProductChange(item.id, 'price', e.value)}
                      />
                    </td>
                    <td>
                      <InputNumber
                        value={item.discount}
                        onValueChange={(e) => handleProductChange(item.id, 'discount', e.value)}
                        suffix="%"
                      />
                    </td>
                    <td>
                      {formatCurrency(item.price * item.qty_order * (1 - item.discount / 100))}
                    </td>
                    <td>
                      <InputText
                        value={item.note}
                        onChange={(e) => handleProductChange(item.id, 'note', e.target.value)}
                      />
                    </td>
                    <td>
                      <Button
                        icon="pi pi-check"
                        className="p-button-text p-button-success"
                        onClick={() => handleSaveRow(item.id)}
                      />
                      <Button
                        icon="pi pi-trash"
                        className="p-button-text p-button-danger"
                        onClick={() => handleDeleteRow(item.id)}
                      />
                    </td>
                  </>
                ) : (
                  <>
                    <td>{item.code}</td>
                    <td>{item.name}</td>
                    <td>
                      {item.image ? (
                        <img src={item.image} alt={item.name} className="thumb" />
                      ) : (
                        '-'
                      )}
                    </td>
                    <td>{item.color}</td>
                    <td>{item.size}</td>
                    <td>{item.qty_order}</td>
                    <td>{item.qty_received}</td>
                    <td>{formatCurrency(item.price)}</td>
                    <td>{item.discount}%</td>
                    <td>
                      {formatCurrency(item.price * item.qty_order * (1 - item.discount / 100))}
                    </td>
                    <td>{item.note}</td>
                    <td>
                      <Button
                        icon="pi pi-pencil"
                        className="p-button-text"
                        onClick={() => handleEditRow(item.id)}
                      />
                      <Button
                        icon="pi pi-trash"
                        className="p-button-text p-button-danger"
                        onClick={() => handleDeleteRow(item.id)}
                      />
                    </td>
                  </>
                )}
              </tr>
            ))}
          </tbody>
        </table>

        <div className="mt-3 text-right">
          <Button label="+ Thêm sản phẩm" className="p-button-outlined" onClick={handleAddRow} />
        </div>
      </Card>

      {/* Nút submit */}
      <div className="submit-section text-right mt-3">
        <Button
          label="Xác nhận đơn hàng"
          icon="pi pi-check"
          className="p-button-success"
          onClick={handleSubmit}
        />
      </div>
    </div>
  );
};

export default OrderPage;
