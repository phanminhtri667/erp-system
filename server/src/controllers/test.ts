import { Request, Response } from "express";


class GetTestControler {
  public getTest = async (req: Request, res: Response) => {
    
    try {
      
      return res.status(200).json('123');
  
    } catch (error) {
      console.error(error);
      return res.status(500).json({
        err: -1,
        mess: "Internal server error",
      });
    }
  };

}

export default new GetTestControler();
