import React from 'react';
import { EOrderStatus, OrderStatusLabel } from './types/order';

interface OrderStatusBadgeProps {
  status: EOrderStatus;
}

/**
 * Hiển thị badge trạng thái đơn hàng
 */
const OrderStatusBadge: React.FC<OrderStatusBadgeProps> = ({ status }) => {
  const colorMap: Record<EOrderStatus, string> = {
    [EOrderStatus.WAITING_ADMIN_APPROVAL]: 'bg-yellow-400',
    [EOrderStatus.ADMIN_APPROVED]: 'bg-blue-500',
    [EOrderStatus.ADMIN_REJECTED]: 'bg-red-500',
    [EOrderStatus.WAITING_DEPOSIT]: 'bg-orange-400',
    [EOrderStatus.DEPOSIT_CONFIRMED]: 'bg-green-500',
    [EOrderStatus.SUPPLIER_PROCESSING]: 'bg-indigo-400',
    [EOrderStatus.SUPPLIER_FINISHED]: 'bg-indigo-600',
    [EOrderStatus.WAREHOUSE_RECEIVED]: 'bg-teal-400',
    [EOrderStatus.WAREHOUSE_PROCESSING]: 'bg-teal-600',
    [EOrderStatus.SHIPPING]: 'bg-sky-400',
    [EOrderStatus.DELIVERED]: 'bg-sky-600',
    [EOrderStatus.COMPLETED]: 'bg-green-700',
    [EOrderStatus.CANCELLED]: 'bg-gray-600',
    [EOrderStatus.ZALO_UPDATED]: 'bg-blue-300',
  };

  return (
    <span
      className={`inline-block px-3 py-1 text-xs font-semibold text-white rounded-full ${colorMap[status]}`}
    >
      {OrderStatusLabel[status] ?? status}
    </span>
  );
};

export default OrderStatusBadge;
