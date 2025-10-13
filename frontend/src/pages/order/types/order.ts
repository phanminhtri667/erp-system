// Enum trạng thái đơn hàng
export enum EOrderStatus {
  /** Sale tạo đơn mới */
  SALE_ORDER = 'SALE_ORDER',

  /** Chờ admin duyệt */
  WAITING_ADMIN_APPROVAL = 'WAITING_ADMIN_APPROVAL',

  /** Admin duyệt đơn */
  ADMIN_APPROVED = 'ADMIN_APPROVED',

  /** Admin từ chối duyệt */
  ADMIN_REJECTED = 'ADMIN_REJECTED',

  /** Chờ khách đặt cọc */
  WAITING_DEPOSIT = 'WAITING_DEPOSIT',

  /** Xác nhận đã nhận cọc */
  DEPOSIT_CONFIRMED = 'DEPOSIT_CONFIRMED',

  /** Đơn đã gửi cho NCC xử lý */
  SUPPLIER_PROCESSING = 'SUPPLIER_PROCESSING',

  /** NCC hoàn tất đơn hàng */
  SUPPLIER_FINISHED = 'SUPPLIER_FINISHED',

  /** Kho xác nhận đã nhận hàng */
  WAREHOUSE_RECEIVED = 'WAREHOUSE_RECEIVED',

  /** Kho đang xử lý đơn giao hàng */
  WAREHOUSE_PROCESSING = 'WAREHOUSE_PROCESSING',

  /** Đang giao hàng */
  SHIPPING = 'SHIPPING',

  /** Giao hàng thành công */
  DELIVERED = 'DELIVERED',

  /** Đơn hàng đã hoàn tất */
  COMPLETED = 'COMPLETED',

  /** Đơn hàng bị hủy */
  CANCELLED = 'CANCELLED',

  /** Zalo cập nhật trạng thái (ngoại lệ hoặc thông tin thêm) */
  ZALO_UPDATED = 'ZALO_UPDATED',
}

export const OrderStatusLabel: Record<EOrderStatus, string> = {
  [EOrderStatus.SALE_ORDER]: 'Đơn hàng mới (Sale tạo)',
  [EOrderStatus.WAITING_ADMIN_APPROVAL]: 'Chờ Admin duyệt',
  [EOrderStatus.ADMIN_APPROVED]: 'Admin đã duyệt',
  [EOrderStatus.ADMIN_REJECTED]: 'Admin từ chối duyệt',
  [EOrderStatus.WAITING_DEPOSIT]: 'Chờ đặt cọc',
  [EOrderStatus.DEPOSIT_CONFIRMED]: 'Đã nhận cọc',
  [EOrderStatus.SUPPLIER_PROCESSING]: 'NCC đang xử lý',
  [EOrderStatus.SUPPLIER_FINISHED]: 'NCC đã hoàn tất',
  [EOrderStatus.WAREHOUSE_RECEIVED]: 'Kho đã nhận hàng',
  [EOrderStatus.WAREHOUSE_PROCESSING]: 'Kho đang xử lý đơn',
  [EOrderStatus.SHIPPING]: 'Đang giao hàng',
  [EOrderStatus.DELIVERED]: 'Giao hàng thành công',
  [EOrderStatus.COMPLETED]: 'Hoàn tất đơn hàng',
  [EOrderStatus.CANCELLED]: 'Đơn hàng bị hủy',
  [EOrderStatus.ZALO_UPDATED]: 'Zalo cập nhật trạng thái',
};

export interface IOrder {
  id: string;
  customer_name: string;
  product_name: string;
  quantity: number;
  status: EOrderStatus;
  created_at: string;
  note?: string;
  updated_at?: string;
}

export interface IOrderCreatePayload {
  customer_name: string;
  product_name: string;
  quantity: number;
}
