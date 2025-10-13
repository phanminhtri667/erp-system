import { useState } from 'react';
import { IOrder, EOrderStatus, IOrderCreatePayload } from './types/order';
import OrderCreateDialog from './OrderCreateDialog';
import OrderList from './orderList';

const mockOrders: IOrder[] = [
  {
    id: String(Math.floor(Math.random() * 8888888)),
    customer_name: 'Nguyễn Văn A',
    product_name: 'Áo sơ mi nam trắng',
    quantity: 2,
    status: EOrderStatus.ADMIN_REJECTED,
    created_at: '2025-10-01T09:00:00Z',
  },
  {
    id: String(Math.floor(Math.random() * 8888888)),
    customer_name: 'Trần Thị B',
    product_name: 'Quần jean nữ xanh',
    quantity: 1,
    status: EOrderStatus.ADMIN_APPROVED,
    created_at: '2025-10-02T10:00:00Z',
  },
  {
    id: String(Math.floor(Math.random() * 8888888)),
    customer_name: 'Phạm Quốc Cường',
    product_name: 'Giày thể thao Nike',
    quantity: 1,
    status: EOrderStatus.WAREHOUSE_PROCESSING,
    created_at: '2025-10-03T11:30:00Z',
  },
  {
    id: String(Math.floor(Math.random() * 8888888)),
    customer_name: 'Lê Minh D',
    product_name: 'Áo hoodie đen',
    quantity: 3,
    status: EOrderStatus.SHIPPING,
    created_at: '2025-10-04T08:45:00Z',
  },
  {
    id: String(Math.floor(Math.random() * 8888888)),
    customer_name: 'Võ Nhật E',
    product_name: 'Túi xách nữ thời trang',
    quantity: 1,
    status: EOrderStatus.DELIVERED,
    created_at: '2025-10-05T15:20:00Z',
  },
  {
    id: String(Math.floor(Math.random() * 8888888)),
    customer_name: 'Nguyễn Hữu F',
    product_name: 'Mũ lưỡi trai',
    quantity: 2,
    status: EOrderStatus.ADMIN_REJECTED,
    created_at: '2025-10-06T12:00:00Z',
  },
  {
    id: String(Math.floor(Math.random() * 8888888)),
    customer_name: 'Đinh Văn G',
    product_name: 'Áo khoác dù',
    quantity: 1,
    status: EOrderStatus.WAREHOUSE_RECEIVED,
    created_at: '2025-10-07T13:10:00Z',
  },
  {
    id: String(Math.floor(Math.random() * 8888888)),
    customer_name: 'Ngô Hoàng H',
    product_name: 'Váy công sở',
    quantity: 2,
    status: EOrderStatus.SHIPPING,
    created_at: '2025-10-08T09:45:00Z',
  },
  {
    id: String(Math.floor(Math.random() * 8888888)),
    customer_name: 'Trịnh Quốc I',
    product_name: 'Balo laptop',
    quantity: 1,
    status: EOrderStatus.WAITING_ADMIN_APPROVAL,
    created_at: '2025-10-09T17:00:00Z',
  },
  {
    id: String(Math.floor(Math.random() * 8888888)),
    customer_name: 'Đặng Thị J',
    product_name: 'Giày cao gót nữ',
    quantity: 1,
    status: EOrderStatus.DELIVERED,
    created_at: '2025-10-10T14:30:00Z',
  },
];

export default function Order() {
  const [orders, setOrders] = useState<IOrder[]>([]);
  const [showCreate, setShowCreate] = useState(false);

  const handleCreate = (data: IOrderCreatePayload) => {
    const newOrder: IOrder = {
      id: Math.floor(Math.random() * 111111).toString(),
      customer_name: data.customer_name,
      product_name: data.product_name,
      quantity: data.quantity,
      status: EOrderStatus.WAITING_DEPOSIT,
      created_at: new Date().toISOString(),
    };
    setOrders((prev) => [newOrder, ...prev]);
    setShowCreate(false);
  };

  const handleChangeStatus = (id: string, status: EOrderStatus) => {
    setOrders((prev) => prev.map((o) => (o.id === id ? { ...o, status } : o)));
  };

  return (
    <div className="p-6 bg-gray-50 min-h-screen">
      <div className="w-full space-y-6 ">
        <div className="flex justify-between items-center">
          <h2 className="text-2xl font-semibold">Quản lý đơn hàng</h2>
          <button
            className="bg-blue-500 text-white px-3 py-2 rounded"
            onClick={() => setShowCreate(true)}
          >
            + Tạo đơn mới
          </button>
        </div>

        <OrderList orders={mockOrders} onChangeStatus={handleChangeStatus} />

        <OrderCreateDialog
          visible={showCreate}
          onHide={() => setShowCreate(false)}
          onSubmit={handleCreate}
        />
      </div>
    </div>
  );
}
