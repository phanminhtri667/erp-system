import { Response } from 'express';

export enum EActionType {
  Get = 'get',
  Create = 'create',
  Update = 'update',
  Delete = 'delete',
}

export enum EStatus {
  Success = 'success',
  Warning = 'warning',
  Error = 'error',
}

const messages: Record<EActionType, { success: string; error: string }> = {
  [EActionType.Get]: {
    success: 'Lấy dữ liệu thành công',
    error: 'Lỗi khi lấy dữ liệu',
  },
  [EActionType.Create]: {
    success: 'Tạo mới thành công',
    error: 'Lỗi khi tạo dữ liệu',
  },
  [EActionType.Update]: {
    success: 'Cập nhật thành công',
    error: 'Lỗi khi cập nhật dữ liệu',
  },
  [EActionType.Delete]: {
    success: 'Xóa thành công',
    error: 'Lỗi khi xóa dữ liệu',
  },
};

const handleResponse = (
  res: Response,
  statusCode: number,
  status: EStatus,
  message: string,
  data?: any,
  error?: any,
) => {
  return res.status(statusCode).json({
    status,
    message,
    ...(data && { data }),
    ...(error && { error }),
  });
};

export const handleSuccess = (res: Response, action: EActionType, data?: any) =>
  handleResponse(res, 200, EStatus.Success, messages[action].success, data);

export const handleNotFound = (res: Response, resourceName = 'Dữ liệu') =>
  handleResponse(res, 404, EStatus.Warning, `${resourceName} không được tìm thấy`);

export const handleError = (res: Response, action: EActionType, error?: any) => {
  console.error(`[${action.toUpperCase()} ERROR]:`, error);
  return handleResponse(res, 500, EStatus.Error, messages[action].error, undefined, error);
};
