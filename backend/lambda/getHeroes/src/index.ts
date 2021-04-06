import {
  APIGatewayEventDefaultAuthorizerContext,
  APIGatewayProxyEventBase,
  APIGatewayProxyHandler,
  Context,
} from 'aws-lambda';
import { DynamoDB } from 'aws-sdk';
import { ScanInput } from 'aws-sdk/clients/dynamodb';
import { APIGatewayProxyResult } from 'aws-lambda/trigger/api-gateway-proxy';

const dynamoDb = new DynamoDB.DocumentClient();
const params: ScanInput = {
  TableName: process.env.DYNAMODB_TABLE || 'Heroes',
};

interface Hero {
  id: string;
  name: string;
}

function getData(): { heroes: Hero[] } {
  const heroes: Hero[] = [
    { id: '11', name: 'Dr Nice' },
    { id: '12', name: 'Narco' },
    { id: '13', name: 'Bombasto' },
    { id: '14', name: 'Celeritas' },
    { id: '15', name: 'Magneta' },
    { id: '16', name: 'RubberMan' },
    { id: '17', name: 'Dynama' },
    { id: '18', name: 'Dr IQ' },
    { id: '19', name: 'Magma' },
    { id: '20', name: 'Tornado' },
  ];
  return { heroes };
}

function prepareResponse(statusCode: number, body: any): APIGatewayProxyResult {
  console.log('Preparing response with', statusCode, body);
  return {
    statusCode,
    body: JSON.stringify(body),
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    },
  };
}

export const handler: APIGatewayProxyHandler = async (
  event: APIGatewayProxyEventBase<APIGatewayEventDefaultAuthorizerContext>,
  context: Context,
) => {
  console.log('Starting Lambda processing');
  try {
    const response = await dynamoDb.scan(params).promise();
    console.log('Handling dynamoDB scan', response, getData(), event, context);
    return prepareResponse(200, { response });
  } catch (err) {
    console.error(err.message, err);
    return err;
  }
};
